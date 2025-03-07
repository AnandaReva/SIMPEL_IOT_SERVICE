#include <WiFiManager.h>
#include <PZEM004Tv30.h>
#include <EEPROM.h>
#include <HTTPClient.h>


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

/* HTTP */
const char* serverUrl = "http://192.168.1.5:5001";

// const char* deviceName = "device_i";
// const char* devicePassword = "qwerqwer";


/* LOG */

const String appVersion = "0.0.1";
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

        Serial.print("[");
        Serial.print(timestamp);
        Serial.print("] - ");
        Serial.print(appName);
        Serial.print(" v");
        Serial.print(appVersion);
        Serial.print(" - ");
        Serial.print(reference_id);
        Serial.print(" - ");
        Serial.print(level);
        Serial.print(" - ");
        Serial.print(message);

        if (data.length() > 0) {
            Serial.print(" - ");
            Serial.print(data);
        }

        Serial.println();
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

bool wifiSetup(String reference_id, String ssid, String password);
void saveWiFiCredentials(String reference_id, String ssid, String password);
void readWiFiCredentials(String reference_id, String &ssid, String &password);
void readSensorData();

void setup() {
  Serial.begin(115200);
  EEPROM.begin(EEPROM_SIZE);

  reference_id = "MAIN";
  logger(INFO, reference_id, "Memulai ESP32...");

  String ssid, password;
  readWiFiCredentials(reference_id, ssid, password);

  bool connected = wifiSetup(reference_id, ssid, password);
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
    previousMillis = currentMillis;

    reference_id = generateReferenceId();
    logger(DEBUG, reference_id, "-----------------------------------------");
    logger(DEBUG, reference_id, "Generated reference id: " + reference_id);

    readSensorData();
  }
}

// 🔹 **Perbaikan `wifiSetup()` dengan return boolean**
bool wifiSetup(String reference_id, String ssid, String password) {
  if (ssid.length() < 1) {
    logger(WARNING, reference_id, "SSID tidak ditemukan, masuk ke mode konfigurasi...");

    if (!wm.autoConnect("ESP32_Config")) {
      logger(ERROR, reference_id, "Gagal connect, restart ESP32...");
      delay(3000);
      ESP.restart();
      return false;
    }

    saveWiFiCredentials(reference_id, WiFi.SSID(), WiFi.psk());
    return true;
  }

  WiFi.begin(ssid.c_str(), password.c_str());
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

void saveWiFiCredentials(String reference_id, String ssid, String password) {
  logger(INFO, reference_id, "Menyimpan SSID & Password ke EEPROM...");

  EEPROM.begin(EEPROM_SIZE);

  for (int i = 0; i < 48; i++) {
    EEPROM.write(SSID_ADDR + i, i < ssid.length() ? ssid[i] : 0);
    EEPROM.write(PASS_ADDR + i, i < password.length() ? password[i] : 0);
  }

  EEPROM.commit();
  logger(EVENT, reference_id, "SSID & Password tersimpan!");
}

void readWiFiCredentials(String reference_id, String &ssid, String &password) {
  logger(INFO, reference_id, "Membaca SSID & Password dari EEPROM...");

  EEPROM.begin(EEPROM_SIZE);

  char ssidBuf[48];
  char passBuf[48];

  for (int i = 0; i < 48; i++) {
    ssidBuf[i] = EEPROM.read(SSID_ADDR + i);
    passBuf[i] = EEPROM.read(PASS_ADDR + i);
  }
  ssid = String(ssidBuf);
  password = String(passBuf);

  logger(INFO, reference_id, "SSID: " + ssid);
}

void readSensorData() {
  float voltage, current, power, energy, frequency, power_factor;

  voltage = pzem.voltage();
  current = pzem.current();
  power = pzem.power();
  energy = pzem.energy();
  frequency = pzem.frequency();
  power_factor = pzem.pf();

  if (!isnan(voltage) && !isnan(current) && !isnan(power) &&
      !isnan(energy) && !isnan(frequency) && !isnan(power_factor)) {
    
    logger(INFO, reference_id, "Valid sensor data:");
    logger(INFO, reference_id, "Voltage: " + String(voltage, 2) + " V");
    logger(INFO, reference_id, "Current: " + String(current, 2) + " A");
    logger(INFO, reference_id, "Power: " + String(power, 2) + " W");
    logger(INFO, reference_id, "Energy: " + String(energy, 2) + " kWh");
    logger(INFO, reference_id, "Frequency: " + String(frequency, 2) + " Hz");
    logger(INFO, reference_id, "Power Factor: " + String(power_factor));
  } else {
    logger(ERROR, reference_id, "Error reading sensor data!");
  }
}

//////////// WEB //////////
int sendGreeting() {
    if (WiFi.status() == WL_CONNECTED) {
        HTTPClient http;
        http.begin(serverUrl);
        http.addHeader("Content-Type", "application/json");

        String payload = "{\"device\":\"ESP32\",\"status\":\"connected\"}";
        int httpResponseCode = http.POST(payload);

        if (httpResponseCode > 0) {
            String response = http.getString();
            logger(INFO, reference_id, "Response code: " + String(httpResponseCode));
            logger(INFO, reference_id, "Response body: " + response);
        } else {
            logger(ERROR, reference_id, "Error sending POST request: " + String(httpResponseCode));
        }

        http.end();
        return httpResponseCode;
    } else {
        logger(ERROR, reference_id, "WiFi not connected");
        return -1;
    }
}
