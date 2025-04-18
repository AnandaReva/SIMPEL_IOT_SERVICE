/**
 * @file sensors/readSensorData.cpp
 */

#include <PZEM004Tv30.h>
#include "logger.h"
#include "globalVar.h"
#include "getTstamp.h"


bool readPzem004T(const std::string &referenceId)
{
    // Ambil data dari sensor
    float voltage = pzem.voltage();
    float current = pzem.current();
    float power = pzem.power();
    float energy = pzem.energy();
    float frequency = pzem.frequency();
    float powerFactor = pzem.pf();

    std::string timestamp = getTstamp().c_str();

    
    // Validasi pembacaan
    if (isnan(voltage) || isnan(current) || isnan(power) ||
    isnan(energy) || isnan(frequency) || isnan(powerFactor))
    {
        LogError(referenceId, " - readPzem004T - Failed to read sensor data");
        return false;
    }
    // Simpan ke variabel global
    sensorData.voltage = voltage;
    sensorData.current = current;
    sensorData.power = power;
    sensorData.energy = energy;
    sensorData.frequency = frequency;
    sensorData.powerFactor = powerFactor;
    sensorData.readTstamp = timestamp;

    // Logging
    LogInfo(referenceId, "-------------------------------------");
    LogInfo(referenceId, " - readPzem004T - Valid sensor data:");
    LogInfo(referenceId, " - readPzem004T - tstamp: " + timestamp);
    LogInfo(referenceId, " - readPzem004T - current: " + std::to_string(current) + " A");
    LogInfo(referenceId, " - readPzem004T - power: " + std::string(power, 2) + " W");
    LogInfo(referenceId, " - readPzem004T - energy: " + std::string(energy, 2) + " kWh");
    LogInfo(referenceId, " - readPzem004T - frequency: " + std::string(frequency, 2) + " Hz");
    LogInfo(referenceId, " - readPzem004T - power Factor: " + std::to_string(powerFactor));
    LogInfo(referenceId, "-------------------------------------");
    return true;
};
