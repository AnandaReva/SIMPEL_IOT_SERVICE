#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "sudah";
const char* WifiPassword = "Satudua12";
const char* serverUrl = "http://192.168.135.66:5001"; // Ganti dengan IP komputer yang menjalankan server

const char* deviceName = "device_j";
const char* devicePassword = "qwerqwer"; // Tambahkan titik koma

void setup() {
  Serial.begin(115200);
  
  WiFi.mode(WIFI_STA);

  // Scan WiFi sebelum menyambungkan
  scanAvailableWifis();

  WiFi.begin(ssid, WifiPassword);

  // Menampilkan informasi perangkat
  Serial.print("Device Name: ");
  Serial.println(deviceName);
  Serial.print("Device Password: ");
  Serial.println(devicePassword);

  // Menampilkan informasi koneksi WiFi
  Serial.print("Connecting to ");
  Serial.println(ssid);

  Serial.print("SSID: ");
  Serial.println(ssid);

  Serial.print("Password: ");
  Serial.println(WifiPassword);

  // Menunggu koneksi ke WiFi
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println("\nConnected!");
  Serial.print("ESP32 IP Address: ");
  Serial.println(WiFi.localIP());

  // Kirim data ke server setelah terhubung
  int response_code = sendGreeting();
  if (response_code == 200) {
    Serial.println("Server responded with success.");
    // Logic lanjutan bisa ditambahkan di sini
  } else {
    Serial.print("Response from server error with code: ");
    Serial.println(response_code);
  }
}

void loop() {
  // Program utama bisa ditambahkan di sini
}

int sendGreeting() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverUrl);  // URL server
    http.addHeader("Content-Type", "application/json");

    String payload = "{\"device\":\"ESP32\",\"status\":\"connected\"}"; // Data JSON yang dikirim
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
    return httpResponseCode; // Mengembalikan response code
  } else {
    Serial.println("WiFi not connected");
    return -1; // Kode error untuk koneksi WiFi gagal
  }
}

void scanAvailableWifis() {
  Serial.println("Scanning available WiFi networks...");

  // Mulai pemindaian jaringan WiFi
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

  // Hapus hasil pemindaian untuk membebaskan memori
  WiFi.scanDelete();
}





void simulateSensoData() {

    

  


  
  
};
