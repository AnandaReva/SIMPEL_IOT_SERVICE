#include "logger.h"
#include "globalVar.h"
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include "generateRandStr.h"
#include "getDeviceData.h"

using namespace websockets;

/* exp ping pong message for checking  :

    device : {
        "type": "ping",
        "device_id": 1,
    }
    server : {
        "type": "pong",
        "device_id": 1,
    }

    // device wait 5 seconds
    // repeat ping and pong


    // if server dont receive ping message for 5 seconds * 3 times
    // server disconnect wsvoid connectWebSocket(const std::string &referenceId)
{

    GlobalVar &gv = GlobalVar::Instance();

    // exp : ws://localhost:5001/device-connect?name=device_i&password=qwerqwer
    LogInfo(referenceId, "Connecting to WebSocket...");
    std::string websocketUrl = gv.GetWebsocketUrl();
    LogDebug(referenceId, "WebSocket server URL: " + websocketUrl);

    websocketUrl += "?name=" + gv.GetDeviceName() + "&password=" + gv.GetDevicePassword();

    LogDebug(referenceId, "Complete WebSocket server URL: " + websocketUrl);

    // send ping  message

    gv.ws.onMessage([referenceId](WebsocketsMessage message)
                    {
        LogInfo(referenceId, "WEBSOCKET - Received message: " + std::string(message.data().c_str()));

        StaticJsonDocument<256> doc;
        DeserializationError error = deserializeJson(doc, String(message.data().c_str()));

        if (error)
        {
            LogError(referenceId, "WEBSOCKET - Failed to parse JSON: " + std::string(error.c_str()));
            return;
        }

        const char* type = doc["type"] | "";

        if (strlen(type) == 0)
        {
            LogError(referenceId, "WEBSOCKET - Missing 'type' field in message");
            return;
        }

        if (
            strcmp(type, "update") != 0 &&
            strcmp(type, "restart") != 0 &&
            strcmp(type, "deep_sleep") != 0)
        {
            LogError(referenceId, "WEBSOCKET - Invalid type: " + std::string(type));
            return;
        }

        if (strcmp(type, "update") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Updating device data...");


            // check device_id
             if device_id == gv.GetDeviceId();

             // check given new credetials
             if name
             gv.SetName


             ///

             gv.SetIsLoopDisabled(true) // void connectWebSocket(const std::string &referenceId)
{

    GlobalVar &gv = GlobalVar::Instance();

    // exp : ws://localhost:5001/device-connect?name=device_i&password=qwerqwer
    LogInfo(referenceId, "Connecting to WebSocket...");
    std::string websocketUrl = gv.GetWebsocketUrl();
    LogDebug(referenceId, "WebSocket server URL: " + websocketUrl);

    websocketUrl += "?name=" + gv.GetDeviceName() + "&password=" + gv.GetDevicePassword();

    LogDebug(referenceId, "Complete WebSocket server URL: " + websocketUrl);

    // send ping  message

    gv.ws.onMessage([referenceId](WebsocketsMessage message)
                    {
        LogInfo(referenceId, "WEBSOCKET - Received message: " + std::string(message.data().c_str()));

        StaticJsonDocument<256> doc;
        DeserializationError error = deserializeJson(doc, String(message.data().c_str()));

        if (error)
        {
            LogError(referenceId, "WEBSOCKET - Failed to parse JSON: " + std::string(error.c_str()));
            return;
        }

        const char* type = doc["type"] | "";

        if (strlen(type) == 0)
        {
            LogError(referenceId, "WEBSOCKET - Missing 'type' field in message");
            return;
        }

        if (
            strcmp(type, "update") != 0 &&
            strcmp(type, "restart") != 0 &&
            strcmp(type, "deep_sleep") != 0)
        {
            LogError(referenceId, "WEBSOCKET - Invalid type: " + std::string(type));
            return;
        }

        if (strcmp(type, "update") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Updating device data...");


            // check device_id
             if device_id == gv.GetDeviceId();

             // check given new credetials
             if name
             gv.SetName


             ///

             gv.SetIsLoopDisabled(true) // disable main loop
             getDeviceData(referenceId)












        }
        else if (strcmp(type, "restart") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Restarting device...");
            delay(100);
            ESP.restart();
        }
        else if (strcmp(type, "deep_sleep") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Entering deep sleep mode...");
            delay(100);
            esp_deep_sleep_start();
        } });

    bool ok = gv.ws.connect(websocketUrl.c_str());
    if (!ok)
    {
        LogError(referenceId, "❌ Failed to connect to WebSocket");
    }
}
disable main loop
             getDeviceData(referenceId)












        }
        else if (strcmp(type, "restart") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Restarting device...");
            delay(100);
            ESP.restart();
        }
        else if (strcmp(type, "deep_sleep") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Entering deep sleep mode...");
            delay(100);
            esp_deep_sleep_start();
        } });

    bool ok = gv.ws.connect(websocketUrl.c_str());
    if (!ok)
    {
        LogError(referenceId, "❌ Failed to connect to WebSocket");
    }
}

        "type": "update",
        "device_id" : "device_id",
        "new_credentials" : {
            "name" : "new device_name",
            "passsword" : "new device_password"

        }

    }
    !!note , update local credentials by given update credetnails only,
    exp : if only name exist , setDeviceName only

*/

void connectWebSocket(const std::string &referenceId)
{
    GlobalVar &gv = GlobalVar::Instance();

    LogInfo(referenceId, "Connecting to WebSocket...");
    std::string websocketUrl = gv.GetWebsocketUrl();
    LogDebug(referenceId, "WebSocket server URL: " + websocketUrl);

    websocketUrl += "?name=" + gv.GetDeviceName() + "&password=" + gv.GetDevicePassword();
    LogDebug(referenceId, "Complete WebSocket server URL: " + websocketUrl);

    gv.ws.onMessage([referenceId, &gv](WebsocketsMessage message)
                    {
        LogInfo(referenceId, "WEBSOCKET - Received message: " + std::string(message.data().c_str()));

        StaticJsonDocument<512> doc;
        DeserializationError error = deserializeJson(doc, message.data());

        if (error)
        {
            LogError(referenceId, "WEBSOCKET - Failed to parse JSON: " + std::string(error.c_str()));
            return;
        }

        const char* type = doc["type"] | "";
        if (strlen(type) == 0)
        {
            LogError(referenceId, "WEBSOCKET - Missing 'type' field in message");
            return;
        }

        if (strcmp(type, "update") != 0 && strcmp(type, "restart") != 0 && strcmp(type, "deep_sleep") != 0)
        {
            LogError(referenceId, "WEBSOCKET - Invalid type: " + std::string(type));
            return;
        }

        if (strcmp(type, "update") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Received update command");

            int incomingDeviceId = doc["device_id"] | -1;
            if (incomingDeviceId != gv.GetDeviceId())
            {
                LogWarning(referenceId, "WEBSOCKET - Device ID mismatch. Ignoring update.");
                return;
            }

            JsonObject newCred = doc["new_device_credentials"];
            if (newCred.isNull())
            {
                LogWarning(referenceId, "WEBSOCKET - No new credentials provided");
                return;
            }

            if (newCred.containsKey("name")) {
                std::string newName = newCred["name"].as<std::string>();
                if (!newName.empty()) {
                    gv.SetDeviceName(newName);
                    LogInfo(referenceId, "WEBSOCKET - Updated device name: " + newName);
                } else {
                    LogWarning(referenceId, "WEBSOCKET - Received empty device name, ignoring");
                }
            }
            
            if (newCred.containsKey("password")) {
                std::string newPassword = newCred["password"].as<std::string>();
                if (!newPassword.empty()) {
                    gv.SetDevicePassword(newPassword);
                    LogInfo(referenceId, "WEBSOCKET - Updated device password");
                } else {
                    LogWarning(referenceId, "WEBSOCKET - Received empty device password, ignoring");
                }
            }
            
            gv.SetIsLoopDisabled(true);  // Nonaktifkan loop sementara
            LogInfo(referenceId, "WEBSOCKET - Fetching updated device data...");
            bool ok = getDeviceData(referenceId);
            if (ok)
            {
                LogInfo(referenceId, "WEBSOCKET - Device data updated successfully");
            }
            else
            {
                LogError(referenceId, "WEBSOCKET - Failed to update device data");
            }

            gv.SetIsLoopDisabled(false); // Aktifkan loop kembali
        }
        else if (strcmp(type, "restart") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Restarting device...");
            delay(100);
            ESP.restart();
        }
        else if (strcmp(type, "deep_sleep") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Entering deep sleep mode...");
            delay(100);
            esp_deep_sleep_start();
        } });

    bool ok = gv.ws.connect(websocketUrl.c_str());
    if (!ok)
    {
        LogError(referenceId, "❌ Failed to connect to WebSocket");
    }
}
