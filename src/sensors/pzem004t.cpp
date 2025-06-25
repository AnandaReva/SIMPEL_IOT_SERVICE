/**
 * @file sensors/readSensorData.cpp
 */

#include <PZEM004Tv30.h>
#include "logger.h"
#include "globalVar.h"
#include "generateTstamp.h"

bool readPzem004T(const std::string &referenceId)
{
    GlobalVar &gv = GlobalVar::Instance();
    float voltage = gv.pzem.voltage();
    float current = gv.pzem.current();
    float power = gv.pzem.power();
    float energy = gv.pzem.energy();
    float frequency = gv.pzem.frequency();
    float powerFactor = gv.pzem.pf();

    std::string currTstampUTC = generateTstamp().c_str();
    if (currTstampUTC.empty())
    {
        LogError(referenceId, "readPzem004T - timestamp invalid");
        return false;
    }

    if (isnan(voltage) || isnan(current) || isnan(power) || isnan(energy) || isnan(frequency) || isnan(powerFactor))
    {
        LogError(referenceId, "readPzem004T - sensor data invalid");
        return false;
    }

    // Ambil bulan saat ini dalam bentuk int
    int currMonth = std::stoi(currTstampUTC.substr(5, 2)); // contoh: "2025-06-25" → "06" → 6
    int lastSetMonth = gv.GetLastResetMonth();
    float lastEnergy = gv.GetLastEnergy();

    float delta = 0.0;

    if (currMonth == lastSetMonth && lastSetMonth != 0)
    {
        delta = lastEnergy + energy;
        LogInfo(referenceId, "readPzem004T - Bulan sama, hitung delta = lastEnergy + energy = " +
                             std::to_string(lastEnergy) + " + " + std::to_string(energy) + " = " + std::to_string(delta));
    }
    else
    {
        LogWarning(referenceId, "readPzem004T - Bulan berubah atau belum diset, reset lastEnergy dan lastResetMonth");
        gv.SetLastEnergy(0.0);
        gv.SetLastResetMonth(0);
        delta = 0.0;
    }

    gv.SetDeltaEnergy(delta);

    gv.SetVoltage(voltage);
    gv.SetCurrent(current);
    gv.SetPower(power);
    gv.SetEnergy(energy);
    gv.SetFrequency(frequency);
    gv.SetPowerFactor(powerFactor);
    gv.SetReadTstamp(currTstampUTC);

    // Log detail
    LogInfo(referenceId, "readPzem004T - Sensor data valid:");
    LogInfo(referenceId, "timestamp: " + currTstampUTC + " UTC");
    LogInfo(referenceId, "current: " + std::to_string(current) + " A");
    LogInfo(referenceId, "power: " + std::to_string(power) + " W");
    LogInfo(referenceId, "raw energy: " + std::to_string(energy) + " kWh");
    LogInfo(referenceId, "delta energy: " + std::to_string(delta) + " kWh");
    LogInfo(referenceId, "frequency: " + std::to_string(frequency) + " Hz");
    LogInfo(referenceId, "power factor: " + std::to_string(powerFactor));

    return true;
}
