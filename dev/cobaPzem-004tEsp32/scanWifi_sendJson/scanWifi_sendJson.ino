#include <PZEM004Tv30.h>

// Gunakan port serial hardware kedua di ESP32 (UART2)
#define PZEM_RX_PIN 16
#define PZEM_TX_PIN 17

HardwareSerial mySerial(1); // UART1 atau UART2 bisa digunakan

PZEM004Tv30 pzem(mySerial, PZEM_RX_PIN, PZEM_TX_PIN);

void setup() {
    Serial.begin(115200);
    Serial.println("PZEM-004T Sensor Monitoring");
}

void loop() {
    float voltage = pzem.voltage();
    if(!isnan(voltage)){
        Serial.print("Voltage: ");
        Serial.print(voltage);
        Serial.println(" V");
    } else {
        Serial.println("Error reading voltage");
    }

    float current = pzem.current();
    if(!isnan(current)){
        Serial.print("Current: ");
        Serial.print(current);
        Serial.println(" A");
    } else {
        Serial.println("Error reading current");
    }

    float power = pzem.power();
    if(!isnan(power)){
        Serial.print("Power: ");
        Serial.print(power);
        Serial.println(" W");
    } else {
        Serial.println("Error reading power");
    }

    float energy = pzem.energy();
    if(!isnan(energy)){
        Serial.print("Energy: ");
        Serial.print(energy);
        Serial.println(" kWh");
    } else {
        Serial.println("Error reading energy");
    }

    Serial.println("----------------------------------");
    delay(2000);
}
