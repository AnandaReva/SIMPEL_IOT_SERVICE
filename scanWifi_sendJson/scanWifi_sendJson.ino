#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoWebsockets.h>

using namespace websockets;

const char* ssid = "hayolo";
const char* WifiPassword = "qwerqwer";
const char* serverUrl = "http://10.4.156.215:5001"; // Ganti dengan IP server

// Credential perangkat
const char* deviceName = "device_i";
const char* devicePassword = "qwerqwer";

// URL WebSocket
String websocket_server = "ws://10.4.156.215:5001/device-connect?name=" + String(deviceName) + "&password=" + String(devicePassword);

// Objek WebSocket
WebsocketsClient client;

// Sensor variable
float voltage;
float current;
float power;
float energy;
float frequency;
float power_factor;

void setup() {
  Serial.begin(115200);
  
  WiFi.mode(WIFI_STA);
  scanAvailableWifis();

  WiFi.begin(ssid, WifiPassword);

  Serial.print("Connecting to ");
  Serial.println(ssid);

  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println("\nConnected!");
  Serial.print("ESP32 IP Address: ");
  Serial.println(WiFi.localIP());

  // Kirim data ke server HTTP setelah terhubung
  int response_code = sendGreeting();
  if (response_code == 200) {
    Serial.println("Server responded with success.");
  } else {
    Serial.print("Response from server error with code: ");
    Serial.println(response_code);
  }

  // Sambungkan WebSocket
  connectWebSocket();
}

void loop() {
  if (!client.available()) {
    Serial.println("WebSocket disconnected, reconnecting...");
    connectWebSocket();
  } else {
    client.poll(); // Periksa pesan masuk
    simulateSensorData();
    delay(1000); // Kirim data setiap detik
  }
}

void connectWebSocket() {
  Serial.print("Connecting to WebSocket: ");
  Serial.println(websocket_server);

  if (client.connect(websocket_server)) {
    Serial.println("Connected to WebSocket server!");
    client.send("Hello from ESP32!"); 
    client.onMessage(onMessageCallback);
  } else {
    Serial.println("WebSocket connection failed!");
  }
}

void onMessageCallback(WebsocketsMessage message) {
  Serial.print("Received Message: ");
  Serial.println(message.data());
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
      Serial.print("Response code: ");
      Serial.println(httpResponseCode);
      Serial.print("Response body: ");
      Serial.println(response);
    } else {
      Serial.print("Error sending POST request: ");
      Serial.println(httpResponseCode);
    }

    http.end();
    return httpResponseCode;
  } else {
    Serial.println("WiFi not connected");
    return -1;
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

void simulateSensorData() {
    // Membuat timestamp saat ini
    long timestamp = millis(); // Bisa diganti dengan waktu Unix jika tersedia
    
    // Menggunakan variabel global, bukan mendeklarasikan ulang
    voltage = random(210, 230) + random(0, 10) / 10.0;  // 210V - 230V
    current = random(1, 5) + random(0, 10) / 10.0;      // 1A - 5A
    power = voltage * current;                         // P = V x I
    energy = random(1000, 5000) + random(0, 100) / 100.0; // 1000 - 5000 kWh
    frequency = 50.0 + random(-5, 5) / 10.0;           // 49.5Hz - 50.5Hz
    power_factor = 0.95 + random(0, 5) / 100.0;        // 0.95 - 0.99

    // Membuat JSON string
    String jsonPayload = "{";
    jsonPayload += "\"Tstamp\":" + String(timestamp) + ",";
    jsonPayload += "\"Voltage\":" + String(voltage, 1) + ",";
    jsonPayload += "\"Current\":" + String(current, 1) + ",";
    jsonPayload += "\"Power\":" + String(power, 2) + ",";
    jsonPayload += "\"Energy\":" + String(energy, 2) + ",";
    jsonPayload += "\"Frequency\":" + String(frequency, 1) + ",";
    jsonPayload += "\"Power_factor\":" + String(power_factor, 2);
    jsonPayload += "}";

    Serial.println("Sending data: " + jsonPayload);

    // Kirim data melalui WebSocket jika koneksi tersedia
    if (client.available()) {
        client.send(jsonPayload);
    } else {
        Serial.println("WebSocket not connected!");
    }
}
