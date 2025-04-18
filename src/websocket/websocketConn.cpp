#include "logger.h"
#include "globalVar.h"
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include "generateRandStr.h"

using namespace websockets;

void connectWebSocket(const std::string &referenceId)
{

    // exp : ws://localhost:5001/device-connect?name=device_i&password=qwerqwer
    LogInfo(referenceId, "Connecting to WebSocket...");
    std::string websocketUrl =  GetWebsocketUrl();
    LogDebug(referenceId, "WebSocket server URL: " + websocketUrl);

    websocketUrl += "?name=" +GetDeviceName() + "&password=" + GetDevicePassword();

    LogDebug(referenceId, "Complete WebSocket server URL: " + websocketUrl);
    
    ws.onMessage([referenceId](WebsocketsMessage message){
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

        if (strcmp(type, "update") != 0 &&
            strcmp(type, "restart") != 0 &&
            strcmp(type, "deep_sleep") != 0)
        {
            LogError(referenceId, "WEBSOCKET - Invalid type: " + std::string(type));
            return;
        }

        if (strcmp(type, "update") == 0)
        {
            LogInfo(referenceId, "WEBSOCKET - Updating device data...");
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

    bool ok = ws.connect(websocketUrl.c_str());
    if (!ok)
    {
        LogError(referenceId, "❌ Failed to connect to WebSocket");
    }
}
