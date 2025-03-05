#include <SoftwareSerial.h>
#include <PZEM004Tv30.h>

// Inisialisasi Software Serial untuk komunikasi dengan PZEM-004T V3
#define RX_PIN 11  // Pin RX Arduino (ke TX PZEM)
#define TX_PIN 10  // Pin TX Arduino (ke RX PZEM)

SoftwareSerial pzemSerial(RX_PIN, TX_PIN); 
PZEM004Tv30 pzem(pzemSerial); // Gunakan Software Serial

void setup() {
    Serial.begin(115200);  // Serial monitor
    pzemSerial.begin(9600); // Komunikasi dengan PZEM-004T
    Serial.println("PZEM-004T V3 Monitor Starting...");
}

void loop() {
    float voltage = pzem.voltage();
    float current = pzem.current();
    float power = pzem.power();
    float energy = pzem.energy();
    float frequency = pzem.frequency();
    float pf = pzem.pf();

    // Cek apakah ada pembacaan yang gagal
    if (isnan(voltage) || isnan(current) || isnan(power) || 
        isnan(energy) || isnan(frequency) || isnan(pf)) {
        Serial.println("Gagal membaca data dari PZEM-004T!");
        return; // Jangan tampilkan nilai apapun
    } 


    // Cetak hasil pembacaan ke Serial Monitor jika sukses
    Serial.print("Voltage: "); Serial.print(voltage); Serial.println(" V");
    Serial.print("Current: "); Serial.print(current); Serial.println(" A");
    Serial.print("Power: "); Serial.print(power); Serial.println(" W");
    Serial.print("Energy: "); Serial.print(energy); Serial.println(" Wh");
    Serial.print("Frequency: "); Serial.print(frequency); Serial.println(" Hz");
    Serial.print("Power Factor: "); Serial.println(pf);
    Serial.println("-----------------------------------");


    


    delay(2000); // Baca data setiap 2 detik
}
