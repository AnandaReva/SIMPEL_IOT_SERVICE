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
 * exp message :
 * {
 *   "type"         : "sensor_data",
 *   "unit_id"      : 1,
 *   "voltage"      : 10,
 *   "current"      : 10,
 *   "power"        : 5,
 *   "energy"       : 0.1,
 *   "frequency"    : 100,
 *   "power_factor" : 1,
 *   "timestamp"    : "2025-04-26 11:32:45"
 * }
 */

#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include "globalVar.h"
#include "logger.h"

void sendSensorData(const std::string &referenceId)
{
    GlobalVar &gv = GlobalVar::Instance();

	

    StaticJsonDocument<250> json;
    json["type"] = "sensor_data";
    json["unit_id"] = gv.GetDeviceId();
    json["voltage"] = gv.GetVoltage();
    json["current"] = gv.GetCurrent();
    json["power"] = gv.GetPower();
    json["energy"] = gv.GetEnergy();
    json["frequency"] = gv.GetFrequency();
    json["power_factor"] = gv.GetPowerFactor();
    json["timestamp"] = gv.GetReadTstamp();
    json["free_memory"] = ESP.getFreeHeap();
    json["total_memory"] = ESP.getHeapSize();
    std::string payload;
    serializeJson(json, payload);

    LogDebug(referenceId, "sendSensorData - Payload: " + payload);

    try
    {
        LogDebug(referenceId, "sendSensorData - Sending message");
        gv.ws.send(payload.c_str());
        LogDebug(referenceId, "sendSensorData - Sent successfully");
    }
    catch (const std::exception &e)
    {
        LogError(referenceId, "sendSensorData", "Failed to send: " + std::string(e.what()));
    }
}
