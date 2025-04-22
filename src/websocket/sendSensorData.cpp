/**
 * @file sendSensorData.cpp
 * @brief Mengirim data sensor ke backend melalui WebSocket.
 *
 * Tabel tujuan di database: device.data
 *
 * Struktur tabel (ringkasan):
 *  Column        | Type                  | Constraints
 *  --------------+------------------------+-------------------------------
 *  id            | bigint                 | PRIMARY KEY
 *  unit_id       | bigint                 | NOT NULL, FK ke device.unit(id)
 *  timestamp     | timestamp              | NOT NULL, DEFAULT now()
 *  voltage       | double precision       | NOT NULL
 *  current       | double precision       | NOT NULL
 *  power         | double precision       | NOT NULL
 *  energy        | double precision       | NOT NULL
 *  frequency     | double precision       | NOT NULL
 *  power_factor  | double precision       | NOT NULL
 *
 * Contoh pesan JSON:
 * {
 *   "unit_id"      : 1,
 *   "voltage"      : 10,
 *   "current"      : 10,
 *   "power"        : 5,
 *   "energy"       : 0.1,
 *   "frequency"    : 100,
 *   "power_factor" : 1,
 *   "timestamp"    : "2025-04-22T12:34:56"
 * }
 */

#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include "globalVar.h"
#include "logger.h"

void sendSensorData(const std::string &referenceId)
{
    StaticJsonDocument<250> json;
    json["unit_id"] = GetDeviceId();
    json["voltage"] = GetVoltage();
    json["current"] = GetCurrent();
    json["power"] = GetPower();
    json["energy"] = GetEnergy();
    json["frequency"] = GetFrequency();
    json["power_factor"] = GetPowerFactor();
    json["timestamp"] = GetReadTstamp();

    std::string payload;
    serializeJson(json, payload);

    try
    {
        LogDebug(referenceId, "sendSensorData - Sending message");
        ws.send(payload.c_str());
        LogDebug(referenceId, "sendSensorData - Sent successfully");
    }
    catch (const std::exception &e)
    {
        LogError(referenceId, "sendSensorData", "Failed to send: " + std::string(e.what()));
    }
}