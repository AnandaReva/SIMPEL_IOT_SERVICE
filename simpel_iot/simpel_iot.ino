/*
TODO: UPDATE DEVICE!!
*/

#include <WiFiManager.h>
#include <PZEM004Tv30.h>
#include <EEPROM.h>
#include <HTTPClient.h>
#include <TimeLib.h>
#include <NTPClient.h>
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>

using namespace websockets;

WiFiManager wm;  // Objek WiFiManager

/* SENSOR */
#define PZEM_RX_PIN 25
#define PZEM_TX_PIN 26

HardwareSerial mySerial(2);  // Menggunakan UART2
PZEM004Tv30 pzem(mySerial, PZEM_RX_PIN, PZEM_TX_PIN);

// Konfigurasi NTP untuk waktu UTC
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 0, 60000);

unsigned long readDataInterval = 5000;  // defualt 5 seconds
unsigned long deviceId = 0;

String deviceName = "";
String devicePassword = "";

/* HTTP */
const String serverUrl = "http://192.168.1.6:5001";
String websocket_server;

// Objek WebSocket
WebsocketsClient client;

/* TODO :
    get device name dan password
*/

const String appVersion = "0.1.0";
const String appName = "SIMPEL_IOT";

String reference_id = "";

const String ERROR = "ERROR";
const String WARNING = "WARNING";
const String EVENT = "EVENT";
const String INFO = "INFO";
const String DEBUG = "DEBUG";

const String LOG_LEVEL = DEBUG;  // Set log level here
/*
0. offline → tidak terhubung ke wifi
1. active → Aktif dan membaca data, serta mengirim data (websocket terhubung)
2. standby → Jika terhubung ke WiFi tetapi tidak ke WebSocket.
3. onhold -> Saat update device data (refetch) dll.
*/
String device_status = "offline";

unsigned long previousMillis = 0;
unsigned long previousMillisWebSocket = 0;
const unsigned long webSocketCheckInterval = 5000;  // Interval cek WebSocket dalam milidetik

// Tambahkan variabel untuk interval pengecekan WiFi
unsigned long previousMillisWiFiCheck = 0;
const unsigned long wifiCheckInterval = 3000;  // Interval dalam milidetik (3 detik)






String getTimestamp() {
  timeClient.update();
  time_t epochTime = timeClient.getEpochTime();

  char buffer[25];
  snprintf(buffer, sizeof(buffer), "%04d-%02d-%02d %02d:%02d:%02d",
           year(epochTime), month(epochTime), day(epochTime),
           hour(epochTime), minute(epochTime), second(epochTime));

  return String(buffer);
}



void logger(String level, String reference_id, String message, String data = "") {
  if ((level == DEBUG && (LOG_LEVEL == DEBUG)) || (level == INFO && (LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) || (level == WARNING && (LOG_LEVEL == WARNING || LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) || (level == ERROR)) {
    String timestamp = getTimestamp();
    String logMsg;
    logMsg.reserve(200);  // Alokasi awal untuk mengurangi alokasi ulang
    logMsg += "[";
    logMsg += timestamp;
    logMsg += "] - ";
    logMsg += appName;
    logMsg += " - ";
    logMsg += appVersion;
    logMsg += " - ";
    logMsg += reference_id;
    logMsg += " - ";
    logMsg += level;
    logMsg += " - ";
    logMsg += device_status;  // offline, standby, reading
    logMsg += " - ";
    logMsg += message;
    if (data.length() > 0) {
      logMsg += " - ";
      logMsg += data;
    }
    Serial.println(logMsg);

    logMsg = "";  // Kosongkan untuk membebaskan memori
  }
}

void updateDeviceStatus(String newStatus) {
  if (newStatus == "active" || newStatus == "standby" || newStatus == "onhold") {
    if (device_status != newStatus)  // hanya update jika status berubah
    {
      device_status = newStatus;
      logger(INFO, reference_id, "Device status updated to: " + device_status);
    }
  } else {
    logger(ERROR, reference_id, "Invalid device status: " + newStatus);
  }
}
String generateReferenceId() {
  const char charset[] = "abcdefghijklmnopqrstuvwxyz0123456789";
  String refId = "";

  // Tambahkan 4 karakter acak dari charset
  for (int i = 0; i < 4; i++) {
    refId += charset[random(0, sizeof(charset) - 1)];
  }

  // Gabungkan timestamp dengan karakter acak
  unsigned long timestamp = millis();
  refId += "_" + String(timestamp);

  return refId;
}

bool isDeviceReady = false;

WiFiManagerParameter customDeviceName("deviceName", "Device Name", deviceName.c_str(), 32);
WiFiManagerParameter customDevicePassword("devicePassword", "Device Password", devicePassword.c_str(), 32);

void checkWiFiConnection() {
  if (WiFi.status() != WL_CONNECTED) {
    updateDeviceStatus("offline");  // Set status perangkat offline
    logger(ERROR, reference_id, "WiFi terputus. Membuka WiFiManager...");
    openWiFiManager();  // Membuka WiFiManager
  }
}



void setup() {
  Serial.begin(115200);
  logger(INFO, reference_id, "SETUP - Memulai ESP32...");

  // Langkah awal: buka WiFi Manager
  updateDeviceStatus("onhold");  // Set status perangkat onhold
startWiFi:
  openWiFiManager();

  // Generate reference ID
  reference_id = generateReferenceId();

  // Coba dapatkan data perangkat

  isDeviceReady = getDeviceData(reference_id);

  // Jika tidak siap, kembali ke WiFi Manager
  if (!isDeviceReady) {
    updateDeviceStatus("offline");  // Set status perangkat offline
    logger(ERROR, reference_id, "SETUP - Perangkat tidak siap. Mengulang proses konfigurasi WiFi...");
    goto startWiFi;  // Kembali ke awal WiFi Manager
  }

  // Ambil parameter kustom setelah konfigurasi
  deviceName = customDeviceName.getValue();
  devicePassword = customDevicePassword.getValue();
  // Perbarui URL WebSocket dengan nama dan password perangkat

  updateDeviceStatus("standby");
  websocket_server = "ws://192.168.1.6:5001/device-connect?name=" + deviceName + "&password=" + devicePassword;

  logger(INFO, reference_id, "SETUP - Perangkat siap digunakan.");
}


void readSensorData() {
  float voltage, current, power, energy, frequency, power_factor;
  voltage = pzem.voltage();
  current = pzem.current();
  power = pzem.power();
  energy = pzem.energy();
  frequency = pzem.frequency();
  power_factor = pzem.pf();

  // Deklarasikan variabel timestamp
  String timestamp = getTimestamp();

  if (!isnan(voltage) && !isnan(current) && !isnan(power) && !isnan(energy) && !isnan(frequency) && !isnan(power_factor)) {

    logger(INFO, reference_id, "-------------------------------------:");
    logger(INFO, reference_id, "Tstamp: " + timestamp);
    logger(INFO, reference_id, "Valid sensor data:");
    logger(INFO, reference_id, "Voltage: " + String(voltage, 2) + " V");
    logger(INFO, reference_id, "Current: " + String(current, 2) + " A");
    logger(INFO, reference_id, "Power: " + String(power, 2) + " W");
    logger(INFO, reference_id, "Energy: " + String(energy, 2) + " kWh");
    logger(INFO, reference_id, "Frequency: " + String(frequency, 2) + " Hz");
    logger(INFO, reference_id, "Power Factor: " + String(power_factor));
    logger(INFO, reference_id, "-------------------------------------:");

    // if connected to webscoket send message
    if (client.available()) {
      sendSensorDataWebSocket(deviceId, timestamp, voltage, current, power, energy, frequency, power_factor);
    } else {
      logger(WARNING, reference_id, "WebSocket not connected. Data not sent.");
    }
  } else {
    logger(INFO, reference_id, "-------------------------------------:");
    logger(ERROR, reference_id, "Error reading sensor data!");
    logger(INFO, reference_id, "-------------------------------------:");
  }
}




void loop() {
  // Periksa koneksi WiFi setiap 3 detik
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillisWiFiCheck >= wifiCheckInterval) {
    previousMillisWiFiCheck = currentMillis;
    checkWiFiConnection();
  }

  // Logika utama loop
  if (currentMillis - previousMillis >= readDataInterval && device_status == "active") {
    previousMillis = currentMillis;
    reference_id = generateReferenceId();

    logger(DEBUG, reference_id, "Free heap: " + String(ESP.getFreeHeap()) + " byte");
    logger(DEBUG, reference_id, "===== Generated reference id: " + reference_id + " =====");

    readSensorData();
  }

  // Memeriksa status WebSocket setiap 5 detik
  if (currentMillis - previousMillisWebSocket >= webSocketCheckInterval) {
    previousMillisWebSocket = currentMillis;

    if (!client.available() && isDeviceReady) {
      updateDeviceStatus("standby");
      logger(ERROR, reference_id, "WebSocket tidak terhubung, mencoba ulang...");
      connectWebSocket();
    } else {
      updateDeviceStatus("active");
      logger(DEBUG, reference_id, "WebSocket terhubung.");
    }
  }
}

void openWiFiManager() {
  logger(INFO, reference_id, "WiFiManager - Membuka mode konfigurasi...");

  // Tambahkan parameter kustom jika belum ditambahkan
  if (wm.getParametersCount() == 0) {
    wm.addParameter(&customDeviceName);
    wm.addParameter(&customDevicePassword);
  }

  // Mulai portal konfigurasi
  if (!wm.startConfigPortal("SIMPEL DEVICE CONFIGURATION")) {
    logger(ERROR, reference_id, "WiFiManager - Gagal masuk mode konfigurasi, restart ESP32...");
    delay(3000);
    ESP.restart();
  }

  // Ambil parameter kustom setelah konfigurasi
  deviceName = customDeviceName.getValue();
  devicePassword = customDevicePassword.getValue();

  logger(INFO, reference_id, "WiFiManager - Device Name: " + deviceName);
  logger(INFO, reference_id, "WiFiManager - Device Password: " + devicePassword);
}

/*
Ezp : {
    "ErrorCode": "000000",
    "ErrorMessage": "",
    "Payload": {
        "device_id": 25,
        "read_interval": 5,
        "status": "success"
    }
}*/
// Fungsi untuk mendapatkan data perangkat

bool getDeviceData(String reference_id) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String UrlDeviceData = serverUrl;
    if (!serverUrl.endsWith("/")) {
      UrlDeviceData += "/";
    }
    UrlDeviceData += "device-get-data";

    logger(DEBUG, reference_id, "UrlDeviceData: " + UrlDeviceData);

    http.begin(UrlDeviceData);
    http.addHeader("Content-Type", "application/json");

    String payload = "{\"name\":\"" + deviceName + "\",\"password\":\"" + devicePassword + "\"}";
    int httpResponseCode = http.POST(payload);

    if (httpResponseCode == 200) {
      String response = http.getString();
      logger(INFO, reference_id, "Response: " + response);

      StaticJsonDocument<1024> doc;  // Buffer diperbesar untuk respons JSON yang lebih besar
      DeserializationError error = deserializeJson(doc, response);
      if (error) {
        logger(ERROR, reference_id, "Gagal parsing JSON respons: " + String(error.c_str()));
        return false;
      }

      // Validasi status
      String status = doc["Payload"]["status"] | "";
      if (status != "success") {
        logger(ERROR, reference_id, "Status respons tidak sukses: " + status);
        return false;
      }

      // Validasi data
      if (!doc["Payload"]["read_interval"].is<int>()) {
        logger(ERROR, reference_id, "Tidak ada nilai 'read_interval' yang valid dalam respons.");
        return false;
      }
      if (!doc["Payload"]["device_id"].is<int>()) {
        logger(ERROR, reference_id, "Tidak ada nilai 'device_id' yang valid dalam respons.");
        return false;
      }

      int deviceReadInterval = doc["Payload"]["read_interval"];
      if (deviceReadInterval <= 0 || deviceReadInterval > 120) {
        logger(ERROR, reference_id, "Nilai 'read_interval' tidak valid: " + String(deviceReadInterval));
        return false;
      }
      readDataInterval = deviceReadInterval * 1000;  // Konversi ke milidetik

      deviceId = doc["Payload"]["device_id"];

      logger(INFO, reference_id, "Berhasil mendapatkan data perangkat device_id : " + String(deviceId) + " read_interval = " + String(readDataInterval) + "ms");

      return true;
    } else {
      logger(ERROR, reference_id, "HTTP Error: " + String(httpResponseCode));
      return false;
    }
  } else {
    logger(ERROR, reference_id, "WiFi tidak terhubung. Mencoba untuk reconnect...");
    WiFi.reconnect();
    delay(5000);  // Tunggu 5 detik sebelum mencoba ulang
    return false;
  }
}

//////////// WEBSOCKET //////////
void connectWebSocket() {
  logger(INFO, reference_id, "Connecting to WebSocket...");
  logger(DEBUG, reference_id, "WebSocket server URL: " + websocket_server);

  client.onMessage([](WebsocketsMessage message) {
    logger(INFO, "WEBSOCKET", "Received message: " + message.data());

    /* exp message : {"user_id" : 1, "role" :"system admin", "type" : "update" } */
    // check user_id : if <= 0 || not integer , ignore
    // check role : if not system admin or system master ignore
    // check type : if not update, restart, turn_off

    StaticJsonDocument<256> doc;
    DeserializationError error = deserializeJson(doc, message.data());
    if (error) {
      logger(ERROR, "WEBSOCKET", "Failed to parse JSON: " + String(error.c_str()));
      return;
    }

    int user_id = doc["user_id"];
    String role = doc["role"];
    String type = doc["type"];

    if (user_id <= 0 || !doc["user_id"].is<int>()) {
      logger(ERROR, "WEBSOCKET", "Invalid user_id: " + String(user_id));
      return;
    }
    if (role != "system admin" && role != "system master") {
      logger(ERROR, "WEBSOCKET", "Invalid role: " + role);
      return;
    }
    if (type != "update" && type != "standby" && type != "reading" && type != "deep_deep") {
      logger(ERROR, "WEBSOCKET", "Invalid type: " + type);
      return;
    }

    logger(INFO, "WEBSOCKET", "Valid message received: user_id = " + String(user_id) + ", role = " + role + ", type = " + type);

    if (type == "update") {
      logger(INFO, "WEBSOCKET", "Updating device data...");
      updateDevice();
    } else if (type == "restart") {
      logger(INFO, "WEBSOCKET", "Restarting device...");
      ESP.restart();
    } else if (type == "turn_off") {
      logger(INFO, "WEBSOCKET", "Turning off device...");
      esp_deep_sleep_start();
    } else {
      logger(WARNING, "WEBSOCKET", "Unknown message type...");
    }
  });

  bool connected = client.connect(websocket_server);
  if (connected) {
    logger(INFO, "WEBSOCKET", "WebSocket Connected!");
  } else {
    logger(ERROR, "WEBSOCKET", "Failed to connect to WebSocket.");
  }
}


void sendSensorDataWebSocket(unsigned long device_id, String tstamp, float voltage, float current, float power, float energy, float frequency, float power_factor) {
  if (client.available()) {
    StaticJsonDocument<256> json;
    json["device_id"] = device_id;
    json["Tstamp"] = tstamp;
    json["Voltage"] = voltage;
    json["Current"] = current;
    json["Power"] = power;
    json["Energy"] = energy;
    json["Frequency"] = frequency;
    json["Power_factor"] = power_factor;

    String payload;
    serializeJson(json, payload);
    client.send(payload);
    logger(DEBUG, reference_id, "Sent WebSocket message: " + payload);
  } else {
    logger(WARNING, reference_id, "WebSocket not connected. Data not sent.");
  }
}

///////////////

void updateDevice() {
  logger(INFO, "WEBSOCKET", "Updating device data...");

  // Set status ke onhold agar tidak mengirim data selama update
  updateDeviceStatus("onhold");

  // Tutup koneksi WebSocket
  if (client.available()) {
    logger(INFO, "WEBSOCKET", "Closing WebSocket connection...");
    client.close();
  }

  // Fetch data terbaru dari server
  bool updated = getDeviceData(reference_id);

  if (updated) {
    logger(INFO, "WEBSOCKET", "Device data updated successfully.");

    // Reconnect WebSocket dengan data baru
    connectWebSocket();

    // Set status kembali ke standby atau active
    updateDeviceStatus(client.available() ? "active" : "standby");
  }

  else {
    logger(ERROR, "WEBSOCKET", "Failed to update device data.");
    // Jika gagal, tetap di standby
    updateDeviceStatus("onhold");  // Set status perangkat onhold
startWiFi:
    openWiFiManager();

    // Generate reference ID
    reference_id = generateReferenceId();

    // Coba dapatkan data perangkat

    isDeviceReady = getDeviceData(reference_id);

    // Jika tidak siap, kembali ke WiFi Manager
    if (!isDeviceReady) {
      updateDeviceStatus("offline");  // Set status perangkat offline
      logger(ERROR, reference_id, "SETUP - Perangkat tidak siap. Mengulang proses konfigurasi WiFi...");
      goto startWiFi;  // Kembali ke awal WiFi Manager
    }

    // Ambil parameter kustom setelah konfigurasi
    deviceName = customDeviceName.getValue();
    devicePassword = customDevicePassword.getValue();
    // Perbarui URL WebSocket dengan nama dan password perangkat

    updateDeviceStatus("standby");
    websocket_server = "ws://192.168.1.6:5001/device-connect?name=" + deviceName + "&password=" + devicePassword;

    logger(INFO, reference_id, "SETUP - Update Berhasil,  Perangkat siap digunakan.");
  }
}