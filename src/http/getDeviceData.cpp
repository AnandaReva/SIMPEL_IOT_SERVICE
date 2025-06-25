/**
 * @file http/getDeviceData.cpp
 *
 * @brief Mengirim permintaan HTTP POST untuk mendapatkan data perangkat dari server.
 *
 * @headers
 * {
 *     "Content-Type": "application/json",
 *     "process": "device_get_data"
 * }
 *
 * @example Request:
 * {
 *     "name": "device_i",
 *     "password": "password123"
 * }
 *
 * @example Response:
 * {
 *     "ErrorCode": "000000",
 *     "ErrorMessage": "",
 *     "payload": {
 *         "device_data": {
 *             "device_id": 29,
 *             "device_read_interval": 1,
 *             "device_last_energy_data": 192
 *         },
 *         "status": "success"
 *     }
 * }
 */

#include <string>
#include "globalVar.h"
#include "logger.h"
#include <NTPClient.h>
#include <ArduinoJson.h>
#include "getDeviceData.h"

bool getDeviceData(const std::string &referenceId)
{
    GlobalVar &gv = GlobalVar::Instance();
    std::string url = gv.GetServerUrl();
    HTTPClient http;

    LogDebug(referenceId, "getDeviceData - Server URL: " + url);
    if (url.empty())
    {
        LogError(referenceId, "getDeviceData - URL empty");
        return false;
    }

    url += "/process";
    http.begin(url.c_str());

    http.addHeader("Content-Type", "application/json");
    http.addHeader("process", "device_get_data");

    std::string payload = "{\"name\":\"" + gv.GetDeviceName() + "\",\"password\":\"" + gv.GetDevicePassword() + "\"}";

    int httpResponseCode = http.POST(payload.c_str());
    if (httpResponseCode != 200)
    {
        LogError(referenceId, "getDeviceData - HTTP request failed, code: " + std::to_string(httpResponseCode));
        http.end();
        return false;
    }

    String response = http.getString();
    LogInfo(referenceId, "getDeviceData - Received response: " + std::string(response.c_str()));

    StaticJsonDocument<1024> doc;
    DeserializationError error = deserializeJson(doc, response);
    if (error)
    {
        LogError(referenceId, "getDeviceData - JSON parse error: " + std::string(error.c_str()));
        http.end();
        return false;
    }

    String status = doc["payload"]["status"] | "success";
    if (status != "success")
    {
        LogError(referenceId, "getDeviceData - Response status: " + std::string(status.c_str()));
        http.end();
        return false;
    }

    // ✅ Ambil device_id dan interval
    if (!doc["payload"]["device_data"]["device_read_interval"].is<int>() ||
        !doc["payload"]["device_data"]["device_id"].is<int>())
    {
        LogError(referenceId, "getDeviceData - device_read_interval/device_id invalid");
        http.end();
        return false;
    }

    unsigned long deviceId = doc["payload"]["device_data"]["device_id"];
    int readInterval = doc["payload"]["device_data"]["device_read_interval"];
    gv.SetDeviceId(deviceId);
    gv.SetReadInterval(readInterval * 1000);

    // ✅ Ambil last_energy
    if (doc["payload"]["device_data"]["device_last_energy_data"].is<float>())
    {
        float lastEnergy = doc["payload"]["device_data"]["device_last_energy_data"];
        gv.SetLastEnergy(lastEnergy);
    }
    else
    {
        gv.SetLastEnergy(0.0);
    }

    // ✅ Ambil last_month
    if (doc["payload"]["last_month"].is<int>())
    {
        gv.SetLastResetMonth(doc["payload"]["last_month"].as<int>());
    }
    else
    {
        gv.SetLastResetMonth(0); // fallback
    }

    LogInfo(referenceId, "getDeviceData - last_energy: " + std::to_string(gv.GetLastEnergy()) +
                             ", last_month: " + std::to_string(gv.GetLastResetMonth()));
    http.end();
    return true;
}
