///*
//   PZEM004Tv30 with ESP32 - Debugging and Fixing Serial Communication
//*/
//
//#include <PZEM004Tv30.h>
//
//// Define RX and TX pins for ESP32
//#define PZEM_RX_PIN 16
//#define PZEM_TX_PIN 17
//#define PZEM_SERIAL Serial2
//
//PZEM004Tv30 pzem(PZEM_SERIAL, PZEM_RX_PIN, PZEM_TX_PIN);
//
//void setup() {
//    // Initialize serial monitor
//    Serial.begin(115200);
//    Serial.println("Starting ESP32 with PZEM004T");
//    
//    // Initialize Serial2 manually to ensure proper communication
//    PZEM_SERIAL.begin(9600, SERIAL_8N1, PZEM_RX_PIN, PZEM_TX_PIN);
//    Serial.println("Serial2 initialized");
//    pzem.setAddress(0xF8);
//
//
//    // Reset the energy counter (optional)
//    // pzem.resetEnergy();
//}
//
//void loop() {
//    Serial.println("Reading PZEM004T data...");
//
//    // Read sensor values
//    float voltage = pzem.voltage();
//    float current = pzem.current();
//    float power = pzem.power();
//    float energy = pzem.energy();
//    float frequency = pzem.frequency();
//    float pf = pzem.pf();
//
//    // Debugging: Check if address is readable
//    uint8_t addr = pzem.readAddress();
//    Serial.print("PZEM Address: ");
//    Serial.println(addr, HEX);
//
//    // Check if data is valid
//    if (isnan(voltage) || isnan(current) || isnan(power) || isnan(energy) || isnan(frequency) || isnan(pf)) {
//        Serial.println("Error: Failed to read from PZEM004T!");
//    } else {
//        Serial.print("Voltage: "); Serial.print(voltage); Serial.println(" V");
//        Serial.print("Current: "); Serial.print(current); Serial.println(" A");
//        Serial.print("Power: "); Serial.print(power); Serial.println(" W");
//        Serial.print("Energy: "); Serial.print(energy, 3); Serial.println(" kWh");
//        Serial.print("Frequency: "); Serial.print(frequency, 1); Serial.println(" Hz");
//        Serial.print("PF: "); Serial.println(pf);
//    }
//
//    Serial.println("--------------------------------");
//    delay(2000);
//}



#include <PZEM004Tv30.h>
#include <SoftwareSerial.h>

// Definisikan pin untuk Software Serial
SoftwareSerial pzemSerial(10, 11); // RX, TX
PZEM004Tv30 pzem(pzemSerial);

void setup() {
    Serial.begin(9600); // Serial Monitor
    Serial.println("PZEM-004T v3 Test");

    // Cek apakah terhubung ke PZEM
    if (!pzem.isConnected()) {
        Serial.println("Gagal terhubung ke PZEM-004T!");
    } else {
        Serial.println("Berhasil terhubung ke PZEM-004T.");
    }
}

void loop() {
    // Baca data dari PZEM
    float voltage = pzem.voltage();
    float current = pzem.current();
    float power = pzem.power();
    float energy = pzem.energy();
    float frequency = pzem.frequency();
    float pf = pzem.pf();

    // Tampilkan data di Serial Monitor
    Serial.print("Tegangan: "); Serial.print(voltage); Serial.println(" V");
    Serial.print("Arus: "); Serial.print(current); Serial.println(" A");
    Serial.print("Daya: "); Serial.print(power); Serial.println(" W");
    Serial.print("Energi: "); Serial.print(energy); Serial.println(" Wh");
    Serial.print("Frekuensi: "); Serial.print(frequency); Serial.println(" Hz");
    Serial.print("Power Factor: "); Serial.println(pf);
    Serial.println("---------------------------------");

    delay(2000); // Tunggu 2 detik sebelum pembacaan berikutnya
}
