#include <PZEM004Tv30.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoWebsockets.h>

using namespace websockets;

// Gunakan port serial hardware kedua di ESP32 (UART2)
#define PZEM_RX_PIN 16
#define PZEM_TX_PIN 17

HardwareSerial mySerial(2); // Menggunakan UART2
PZEM004Tv30 pzem(mySerial, PZEM_RX_PIN, PZEM_TX_PIN);

// Sensor variable
float voltage, current, power, energy, frequency, power_factor;

const char* ssid = "hayolo";
const char* WifiPassword = "qwerqwer";
const char* serverUrl = "http://192.168.137.1:5001"; // Ganti dengan IP server

// Credential perangkat
const char* deviceName = "device_i";
const char* devicePassword = "qwerqwer";

String reference_id = "";

// URL WebSocket
String websocket_server = "ws://192.168.137.1:5001/device-connect?name=" + String(deviceName) + "&password=" + String(devicePassword);

// Objek WebSocket
WebsocketsClient client;

unsigned long lastReconnectAttempt = 0;

const String ERROR = "ERROR";
const String WARNING = "WARNING";
const String EVENT = "EVENT";
const String INFO = "INFO";
const String DEBUG = "DEBUG";

const String LOG_LEVEL = DEBUG; // Set log level here

void logger(String level, String reference_id, String message) {
    if ((level == DEBUG && (LOG_LEVEL == DEBUG)) ||
        (level == INFO && (LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) ||
        (level == WARNING && (LOG_LEVEL == WARNING || LOG_LEVEL == INFO || LOG_LEVEL == DEBUG)) ||
        (level == ERROR)) {
        
        unsigned long timestamp = millis();
        Serial.print("[");
        Serial.print(timestamp);
        Serial.print("] ");
        Serial.print(reference_id);
        Serial.print(" - ");
        Serial.print(level);
        Serial.print(" - ");
        Serial.println(message);
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


void setup() {
    Serial.begin(115200);
  
    
    logger(DEBUG, "SETUP", "Serial begin: 115200");

    WiFi.mode(WIFI_STA);
    scanAvailableWifis();

    WiFi.begin(ssid, WifiPassword);
    logger(DEBUG, "SETUP", "Connecting to WiFi: " + String(ssid));

    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
            //logger(DEBUG, "SETUP"i: " + .);
    }

    logger(INFO, "SETUP", "WiFi connected. IP Address: " + WiFi.localIP().toString());

    int response_code = sendGreeting();
    if (response_code == 200) {
        logger(INFO, "SETUP", "Server responded with success.");
    } else {
        logger(ERROR, "SETUP", "Response from server error with code: " + String(response_code));
    }

    connectWebSocket();
}

unsigned long previousMillis = 0; // Timer untuk loop utama
const unsigned long interval = 1000; // Interval 1 detik

void loop() {
    unsigned long currentMillis = millis();

    // Cek apakah sudah 1 detik sejak iterasi terakhir
    if (currentMillis - previousMillis >= interval) {
        previousMillis = currentMillis; // Update timer

        reference_id = generateReferenceId();
        logger(DEBUG, reference_id, "-----------------------------------------");
        logger(DEBUG, reference_id, "Generated reference id: " + reference_id);


        readSensorData(); 

  
        if (!client.available()) {
            unsigned long reconnectMillis = millis();
            if (reconnectMillis - lastReconnectAttempt >= 5000) { // Reconnect setiap 5 detik
                lastReconnectAttempt = reconnectMillis;
                logger(WARNING, reference_id, "WebSocket disconnected, reconnecting...");
                connectWebSocket();
            }
        } else {
            client.poll(); // Periksa pesan WebSocket
        }
    }
}


void readSensorData() {
    voltage = pzem.voltage();
    current = pzem.current();
    power = pzem.power();
    energy = pzem.energy();
    frequency = pzem.frequency();
    power_factor = pzem.pf();

    if (!isnan(voltage) && !isnan(current) && !isnan(power) 
        && !isnan(energy) && !isnan(frequency) && !isnan(power_factor)) {
        
        logger(INFO, reference_id, "Valid sensor data:");
        logger(INFO, reference_id, "Voltage: " + String(voltage, 2) + " V");
        logger(INFO, reference_id, "Current: " + String(current, 2) + " A");
        logger(INFO, reference_id, "Power: " + String(power, 2) + " W");
        logger(INFO, reference_id, "Energy: " + String(energy, 2) + " kWh");
        logger(INFO, reference_id, "Frequency: " + String(frequency, 2) + " Hz");
        logger(INFO, reference_id, "Power Factor: " + String(power_factor));

        // Hanya kirim data jika WebSocket terhubung
        if (client.available()) {
            sendSensorDataWebSocket(voltage, current, power, energy, frequency, power_factor);
        } else {
            logger(WARNING, reference_id, "WebSocket not connected. Data not sent.");
        }
    } else {
        logger(ERROR, reference_id, "Error reading sensor data!");
    }
}


void scanAvailableWifis() {
  Serial.println("Scanning available WiFi networks...");
  int n = WiFi.scanNetworks();
  
  Serial.println("Scan completed.");
  if (n == 0) {
      Serial.println("No networks found.");
  } else {
      Serial.printf("%d networks found:\n", n);
      Serial.println("Nr | SSID                             | RSSI | CH | Encryption");
      for (int i = 0; i < n; ++i) {
          Serial.printf("%2d | %-32.32s | %4d | %2d | ", i + 1, WiFi.SSID(i).c_str(), WiFi.RSSI(i), WiFi.channel(i));
          
          switch (WiFi.encryptionType(i)) {
              case WIFI_AUTH_OPEN: Serial.print("Open"); break;
              case WIFI_AUTH_WEP: Serial.print("WEP"); break;
              case WIFI_AUTH_WPA_PSK: Serial.print("WPA"); break;
              case WIFI_AUTH_WPA2_PSK: Serial.print("WPA2"); break;
              case WIFI_AUTH_WPA_WPA2_PSK: Serial.print("WPA+WPA2"); break;
              case WIFI_AUTH_WPA2_ENTERPRISE: Serial.print("WPA2-EAP"); break;
              case WIFI_AUTH_WPA3_PSK: Serial.print("WPA3"); break;
              case WIFI_AUTH_WPA2_WPA3_PSK: Serial.print("WPA2+WPA3"); break;
              case WIFI_AUTH_WAPI_PSK: Serial.print("WAPI"); break;
              default: Serial.print("Unknown");
          }
          Serial.println();
          delay(10);
      }
  }
  Serial.println("");
  WiFi.scanDelete();
}

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

void connectWebSocket() {
    logger(INFO, reference_id, "Connecting to WebSocket: " + websocket_server);

    if (client.connect(websocket_server)) {
        logger(INFO, reference_id, "Connected to WebSocket server!");
        client.send("Hello from ESP32!");
        client.onMessage(onMessageCallback);
    } else {
        logger(ERROR, reference_id, "WebSocket connection failed!");
    }
}

void onMessageCallback(WebsocketsMessage message) {
    logger(INFO, reference_id, "Received Message: " + message.data());
}

void sendSensorDataWebSocket(float voltage, float current, float power, float energy, float frequency, float power_factor) {
    if (client.available()) {
        time_t now = time(nullptr);
        struct tm timeinfo;
        gmtime_r(&now, &timeinfo);
        char timestamp[25];
        strftime(timestamp, sizeof(timestamp), "%Y-%m-%dT%H:%M:%S", &timeinfo);

        String payload = "{";
        payload += "\"Tstamp\":\"" + String(timestamp) + "\",";
        payload += "\"Voltage\":" + String(voltage, 2) + ",";
        payload += "\"Current\":" + String(current, 2) + ",";
        payload += "\"Power\":" + String(power, 2) + ",";
        payload += "\"Energy\":" + String(energy, 2) + ",";
        payload += "\"Frequency\":" + String(frequency, 2) + ",";
        payload += "\"Power_factor\":" + String(power_factor, 2);
        payload += "}";

        client.send(payload);
        logger(DEBUG, reference_id, "Sent WebSocket message: " + payload);
    } else {
        logger(WARNING, reference_id, "WebSocket not connected. Data not sent.");
    }
}
