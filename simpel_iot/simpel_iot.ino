#include <WiFiManager.h>
#include <PZEM004Tv30.h>
#include <EEPROM.h>
#include <HTTPClient.h>
#include <TimeLib.h> 
#include <NTPClient.h>


/* WIFI MANAGER */
#define EEPROM_SIZE 96  // Alokasi EEPROM
#define SSID_ADDR 0     // Alamat awal untuk SSID
#define PASS_ADDR 48    // Alamat awal untuk Password
WiFiManager wm;  // Objek WiFiManager

/* SENSOR */
#define PZEM_RX_PIN 16
#define PZEM_TX_PIN 17

HardwareSerial mySerial(2); // Menggunakan UART2
PZEM004Tv30 pzem(mySerial, PZEM_RX_PIN, PZEM_TX_PIN);


// Konfigurasi NTP untuk waktu UTC
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 0, 60000);  // Gunakan UTC (offset 0)



// ignore 
//int readSensorInterval = 1000; // default
// String deviceName = "" ; 
// String devicePassword = ""; 


/* HTTP */
const char* serverUrl = "http://192.168.1.5:5001";

// const char* deviceName = "device_i";
// const char* devicePassword = "qwerqwer";


/* LOG */

/* TODO :
    get device name dan password

*/

const String appVersion = "0.0.3";
const String appName = "SIMPEL_IOT";

String reference_id = "";

const String ERROR = "ERROR";
const String WARNING = "WARNING";
const String EVENT = "EVENT";
const String INFO = "INFO";
const String DEBUG = "DEBUG";

const String LOG_LEVEL = DEBUG; // Set log level here

void logger(String level, String reference_id, String message, String data = "") {
    if ((level == DEBUG && (LOG_LEVEL == DEBUG)) ||
        (level == INFO && (LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) ||
        (level == WARNING && (LOG_LEVEL == WARNING || LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) ||
        (level == ERROR)) {

        unsigned long timestamp = millis();
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
        logMsg += message;

        if (data.length() > 0) {
            logMsg += " - ";
            logMsg += data;
        }

        Serial.println(logMsg);
        
        logMsg = ""; // Kosongkan untuk membebaskan memori
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

bool wifiSetup(String reference_id, String ssid, String wifi_password);
void saveWiFiCredentials(String reference_id, String ssid, String wifi_password);
void readWiFiCredentials(String reference_id, String &ssid, String &wifi_password);
void readSensorData();

void setup() {
  Serial.begin(115200);
  EEPROM.begin(EEPROM_SIZE);

  reference_id = "MAIN";
  logger(INFO, reference_id, "Memulai ESP32...");

  String ssid, wifi_password;
  readWiFiCredentials(reference_id, ssid, wifi_password);

  bool connected = wifiSetup(reference_id, ssid, wifi_password);
  if (connected) {
    logger(INFO, reference_id, "CONNECTED TO INTERNET");

    int response_code = sendGreeting();
    if (response_code == 200) {
        logger(INFO, "SETUP", "Server responded with success.");
    } else {
        logger(ERROR, "SETUP", "Response from server error with code: " + String(response_code));
    }

  } else {
    logger(ERROR, reference_id, "ESP32 gagal terhubung ke WiFi.");
  }
}

unsigned long previousMillis = 0;
const unsigned long interval = 1000;

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {

    logger(DEBUG, reference_id, "Free heap: " + String(ESP.getFreeHeap()) + "byte");
    previousMillis = currentMillis;

    reference_id = generateReferenceId();
    
    logger(DEBUG, reference_id, "===== Generated reference id: " + reference_id + " =====");

    readSensorData();
  }
}

// 🔹 **Perbaikan `wifiSetup()` dengan return boolean**
bool wifiSetup(String reference_id, String ssid, String wifi_password) {
  if (ssid.length() < 1 || wifi_password.length() < 1) {
    logger(WARNING, reference_id, "SSID tidak ditemukan, masuk ke mode konfigurasi...");

    if (!wm.autoConnect("SIMPEL CONFIGURATION")) {
      logger(ERROR, reference_id, "Gagal connect, restart ESP32...");
      delay(3000);
      ESP.restart();
      return false;
    }

    saveWiFiCredentials(reference_id, WiFi.SSID(), WiFi.psk());
    return true;
  }

  WiFi.begin(ssid.c_str(), wifi_password.c_str());
  logger(INFO, reference_id, "Menghubungkan ke WiFi: " + ssid);

  int timeout = 15;
  while (WiFi.status() != WL_CONNECTED && timeout-- > 0) {
    delay(1000);
    Serial.print(".");
  }

  if (WiFi.status() == WL_CONNECTED) {
    logger(INFO, reference_id, "Terhubung ke WiFi! IP Address: " + WiFi.localIP().toString());
    return true;
  } else {
    logger(ERROR, reference_id, "Gagal terhubung, masuk ke mode konfigurasi...");
    if (!wm.autoConnect("SIMPEL DEVICE CONFIGURATION")) {
      logger(ERROR, reference_id, "Gagal connect, restart ESP32...");
      delay(3000);
      ESP.restart();
      return false;
    }

    saveWiFiCredentials(reference_id, WiFi.SSID(), WiFi.psk());
    return true;
  }
}

void saveWiFiCredentials(String reference_id, String ssid, String wifi_password) {
  logger(INFO, reference_id, "Menyimpan SSID & Password ke EEPROM...");

  EEPROM.begin(EEPROM_SIZE);

  for (int i = 0; i < 48; i++) {
    EEPROM.write(SSID_ADDR + i, i < ssid.length() ? ssid[i] : 0);
    EEPROM.write(PASS_ADDR + i, i < wifi_password.length() ? wifi_password[i] : 0);
  }

  EEPROM.commit();
  logger(EVENT, reference_id, "SSID & Password tersimpan!");
}

void readWiFiCredentials(String reference_id, String &ssid, String &wifi_password) {
  logger(INFO, reference_id, "Membaca SSID & Password dari EEPROM...");

  EEPROM.begin(EEPROM_SIZE);

  char ssidBuf[48];
  char passBuf[48];

  for (int i = 0; i < 48; i++) {
    ssidBuf[i] = EEPROM.read(SSID_ADDR + i);
    passBuf[i] = EEPROM.read(PASS_ADDR + i);
  }
  ssid = String(ssidBuf);
  wifi_password = String(passBuf);

  logger(INFO, reference_id, "SSID: " + ssid);
}

String getTimestamp() {
    timeClient.update();
    time_t epochTime = timeClient.getEpochTime();
    
    char buffer[25];
    snprintf(buffer, sizeof(buffer), "%04d-%02d-%02d %02d:%02d:%02d",
             year(epochTime), month(epochTime), day(epochTime),
             hour(epochTime), minute(epochTime), second(epochTime));
    
    return String(buffer);
}


void readSensorData() {
  float voltage, current, power, energy, frequency, power_factor;
''
  voltage = pzem.voltage();
  current = pzem.current();
  power = pzem.power();
  energy = pzem.energy();
  frequency = pzem.frequency();
  power_factor = pzem.pf();

  // Deklarasikan variabel timestamp
  String timestamp = getTimestamp();

  if (!isnan(voltage) && !isnan(current) && !isnan(power) &&
      !isnan(energy) && !isnan(frequency) && !isnan(power_factor)) {
    
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
  } else {
    logger(INFO, reference_id, "-------------------------------------:");
    logger(ERROR, reference_id, "Error reading sensor data!");
    logger(INFO, reference_id, "-------------------------------------:");
  }
}

//////////// WEB //////////
int sendGreeting() {
    if (WiFi.status() == WL_CONNECTED) {
        HTTPClient http;
        http.begin(serverUrl);
        http.addHeader("Content-Type", "application/json");

        // Gunakan reserve untuk mengurangi fragmentasi heap
        String payload;
        payload.reserve(50);  
        payload = "{\"device\":\"ESP32\",\"status\":\"connected\"}";

        int httpResponseCode = http.POST(payload);

        if (httpResponseCode > 0) {
            String response;
            response.reserve(100);  // Alokasi memori sebelum digunakan
            response = http.getString();
            logger(INFO, reference_id, "Response code: " + String(httpResponseCode));
            logger(INFO, reference_id, "Response body: " + response);
            
            response = ""; // Kosongkan untuk membebaskan memori
        } else {
            logger(ERROR, reference_id, "Error sending POST request: " + String(httpResponseCode));
        }

        http.end(); // Pastikan HTTPClient ditutup untuk membebaskan memori
        payload = ""; // Kosongkan payload untuk menghindari memory leak

        return httpResponseCode;
    } else {
        logger(ERROR, reference_id, "WiFi not connected");
        return -1;
    }
}

