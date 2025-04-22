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
 *     "Payload": {
 *         "device_data": {
 *             "device_id": 29,
 *             "device_read_interval": 1
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
    std::string url = GetServerUrl();
    LogDebug(referenceId, "getDeviceData - Server URL: " + url);

    if (url.empty())
    {
        LogError(referenceId, "getDeviceData - URL empty " + url);
        return false;
    }

    http.begin(url.c_str());

    // Tambahkan header yang dibutuhkan
    http.addHeader("Content-Type", "application/json");
    http.addHeader("process", "device_get_data");

    // Bangun payload JSON
    std::string payload = "{\"name\":\"" + GetDeviceName() + "\",\"password\":\"" + GetDevicePassword() + "\"}";

    int httpResponseCode = http.POST(payload.c_str());

    if (httpResponseCode == 200)
    {
        String response = http.getString();
        LogInfo(referenceId, "getDeviceData - Received response: " + std::string(response.c_str()));

        StaticJsonDocument<1024> doc;
        DeserializationError error = deserializeJson(doc, response);
        if (error)
        {
            LogError(referenceId, "getDeviceData - Failed to parse JSON response: " + std::string(error.c_str()));
            return false;
        }

        String status = doc["Payload"]["status"] | "success"; // Optional
        if (status != "success")
        {
            LogError(referenceId, "getDeviceData - Response status not successful: " + std::string(status.c_str()));
            return false;
        }

        // Validasi dan ambil data
        if (!doc["Payload"]["device_data"]["device_read_interval"].is<int>() ||
            !doc["Payload"]["device_data"]["device_id"].is<int>())
        {
            LogError(referenceId, "getDeviceData - 'device_read_interval' or 'device_id' is invalid.");
            return false;
        }

        unsigned long deviceId = doc["Payload"]["device_data"]["device_id"];

        int readInterval = doc["Payload"]["device_data"]["device_read_interval"];
        if (readInterval <= 0 || readInterval > 120)
        {
            LogError(referenceId, "getDeviceData - 'read_interval' out of range: " + std::to_string(readInterval));
            return false;
        }

        // Simpan ke variabel global
        SetReadInterval(readInterval * 1000);
        SetDeviceId(deviceId);

        LogInfo(referenceId, "getDeviceData - Success. device_id: " +
                                 std::to_string(GetDeviceId()) + ", read_interval: " +
                                 std::to_string(GetReadInterval()) + " ms");

        http.end();
        return true;
    }
    else
    {
        LogError(referenceId, "getDeviceData - HTTP request failed, code: " + std::to_string(httpResponseCode));
    }

    http.end();
    return false;
}
