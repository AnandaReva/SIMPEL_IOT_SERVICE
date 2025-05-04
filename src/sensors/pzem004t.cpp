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
    // Ambil data dari sensor
    float voltage = gv.pzem.voltage();
    float current = gv.pzem.current();
    float power = gv.pzem.power();
    float energy = gv.pzem.energy();
    float frequency = gv.pzem.frequency();
    float powerFactor = gv.pzem.pf();

    std::string currTstampUTC = generateTstamp().c_str();

    // validate timestamp
    if (currTstampUTC.empty() || currTstampUTC == "")
    {
        LogError(referenceId, " - readPzem004T - timestamp invalid, currTstampUTC: " + currTstampUTC);
        return false;
    }

    // Validasi pembacaan
    if (isnan(voltage) || isnan(current) || isnan(power) ||
        isnan(energy) || isnan(frequency) || isnan(powerFactor))
    {
        if (isnan(voltage))
            LogError(referenceId, " - readPzem004T - voltage is NaN");
        if (isnan(current))
            LogError(referenceId, " - readPzem004T - current is NaN");
        if (isnan(power))
            LogError(referenceId, " - readPzem004T - power is NaN");
        if (isnan(energy))
            LogError(referenceId, " - readPzem004T - energy is NaN");
        if (isnan(frequency))
            LogError(referenceId, " - readPzem004T - frequency is NaN");
        if (isnan(powerFactor))
            LogError(referenceId, " - readPzem004T - powerFactor is NaN");

        LogError(referenceId, " - readPzem004T - Failed to read sensor data");
        return false;
    }

    // Check if new month
    /* check if curr tstamp month is different from last tstamp month,
    if yes, check energy value if <=0, to ensure reset energy only once
    if no , set last energy to 0.0 ,


    */

    // 1. Ambil bulan sekarang
    std::string currentMonth = currTstampUTC.substr(0, 7);

    // 2. Ambil informasi dari server (sudah diset saat booting)
    double serverLastEnergy = gv.GetLastEnergy(); // data dari response server
    std::string lastResetMonth = gv.GetLastResetMonth();

    // 3. Reset hanya jika belum dilakukan bulan ini dan server memberi 0 (indikasi bulan baru)
    if (serverLastEnergy == 0.0 && currentMonth != lastResetMonth)
    {
        if (energy > 0.0)
        {
            gv.pzem.resetEnergy(); // reset nilai energi ke 0
            gv.SetLastResetMonth(currentMonth);
            LogInfo(referenceId, " - readPzem004T - New month detected: " + currentMonth);
            LogInfo(referenceId, " - readPzem004T - Energy reset performed.");
        }
        else
        {
            LogInfo(referenceId, " - readPzem004T - Energy already 0.0, no reset needed.");
        }
    }

    // Simpan ke variabel global
    gv.SetVoltage(voltage);
    gv.SetCurrent(current);
    gv.SetPower(power);
    gv.SetEnergy(energy);
    gv.SetFrequency(frequency);
    gv.SetPowerFactor(powerFactor);
    gv.SetReadTstamp(currTstampUTC);

    // Jika last_energy tidak 0, set data dan reset
    if (gv.GetLastEnergy() != 0.0)
    {

        LogInfo(referenceId, " - readPzem004T - last_energy: " + std::to_string(gv.GetLastEnergy()));
        gv.SetLastEnergy(energy); // Set data energi terakhir
        LogInfo(referenceId, " - readPzem004T - last_energy set to: " + std::to_string(gv.GetLastEnergy()));
        gv.SetLastEnergy(0.0); // Reset setelah diset
        LogDebug(referenceId, " - readPzem004T - last_energy reset to 0.0");
    }

    // Logging
    LogInfo(referenceId, "-------------------------------------");
    LogInfo(referenceId, " - readPzem004T - Valid sensor data:");
    LogInfo(referenceId, " - readPzem004T - timestamp: " + gv.GetReadTstamp() + " UTC");
    LogInfo(referenceId, " - readPzem004T - current: " + std::to_string(gv.GetCurrent()) + " A");
    LogInfo(referenceId, " - readPzem004T - power: " + std::to_string(gv.GetPower()) + " W");
    LogInfo(referenceId, " - readPzem004T - energy: " + std::to_string(gv.GetEnergy()) + " kWh");
    LogInfo(referenceId, " - readPzem004T - frequency: " + std::to_string(gv.GetFrequency()) + " Hz");
    LogInfo(referenceId, " - readPzem004T - power Factor: " + std::to_string(gv.GetPowerFactor()));
    LogInfo(referenceId, "-------------------------------------");

    return true;
};
