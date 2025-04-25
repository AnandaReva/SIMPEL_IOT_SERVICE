/**
 * @file main.cpp
 * !!! DONT DELETE COMMENTS
 *
 */

/* ✅ Startup Flow
Open WiFi Manager
1.1 If connection is successful:
    → Assign and save device credentials (WiFi + device info).
1.2 If connection fails:
    → Repeat the process until success.

Fetch Device Data (getDeviceData)
2.1 If successful:
    → Assign the received data to deviceData.
2.2 If it fails:
    a. Retry a limited number of times.
    b. If still failing → reopen WiFi Manager (go back to step 1).

Read and Send Sensor Data
3.1 If deviceData is available:
    a. Read sensor values.
    b. Add deviceId and timestamp to the payload.
    c. Send the message to the server.

Connect to WebSocket
4.1 If connection is successful:
    → Continue normal operation.
4.2 If connection fails:
    a. Retry a limited number of times.
    b. If still failing:
        → Remove any WebSocket connection.
        → Reopen WiFi Manager (go back to step 1).

 */
/* 🔄 Device Data Update via WebSocket
Receive WebSocket message with type update
→ Message contains instruction to update the device data.

Re-fetch Device Data using deviceId
2.1 If successful:
    → Assign the updated data to deviceData.
2.2 If it fails:
    a. Retry a limited number of times.
    b. If still failing:
        → Remove WebSocket connection.
        → Reopen WiFi Manager (go back to Startup Flow step 1).

 */

#include <Arduino.h>
#include <WiFiManager.h>
#include <PZEM004Tv30.h>
#include <HTTPClient.h>
#include <TimeLib.h>
#include <NTPClient.h>
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include <string>

#include "logger.h"
#include "globalVar.h"
#include "openWiFiManager.h"
#include "generateRandStr.h"
#include "getDeviceData.h"
#include "websocketConn.h"
#include "sendSensorData.h"
#include "pzem004t.h"

bool isDisableLoop = true;
bool isConnectedToWifi = false;

// Function prototypes
void onWebSocketOpen();
void onWebSocketClose();
void startupFlow();

void watchWebSocketStatus()
{
    ws.onEvent([](websockets::WebsocketsEvent event, String data)
               {
         switch (event){
         case websockets::WebsocketsEvent::ConnectionOpened:
             onWebSocketOpen();
             break;
         case websockets::WebsocketsEvent::ConnectionClosed:
             onWebSocketClose();
             break;
         default:
             {std::string referenceId = generateRandStr(8);
                 LogWarning(referenceId, "WEBSOCKET - Unknown event");
             }
             break;
         } });
}

void startWiFiAndGetDeviceData()
{
    const int maxStartupAttempts = 3;
    const int maxGetDataAttempts = 3;

    int startupAttempt = 0;

    while (startupAttempt < maxStartupAttempts)
    {
        startupAttempt++;
        SetReferenceId("SETUP");
        LogInfo(GetReferenceId(), "Startup Attempt #" + std::to_string(startupAttempt));

        // Step 1: Buka WiFi Manager
        openWiFiManager(GetReferenceId());

        // Step 2: Ambil data perangkat
        int getDataTryCount = 0;
        bool isDataReceived = false;

        while (getDataTryCount < maxGetDataAttempts)
        {
            getDataTryCount++;
            LogInfo(GetReferenceId(), "Trying to get device data... Attempt #" + std::to_string(getDataTryCount));
            delay(2000);

            isDataReceived = getDeviceData(GetReferenceId());
            if (isDataReceived)
                break;
        }

        if (isDataReceived)
        {
            LogInfo(GetReferenceId(), "✅ Device data retrieved successfully");
            return; // Lanjut ke WebSocket
        }

        LogError(GetReferenceId(), "❌ Failed to get device data. Reopening WiFi Manager...");
        WiFi.disconnect(true); // Reset koneksi WiFi
        delay(1000);
    }

    LogError(GetReferenceId(), "❌ All startup attempts failed. Restarting device...");
    ESP.restart();
}

void tryConnectWebSocket()
{
    const int maxWebSocketAttempts = 3;
    int wsFailCount = 0;

    while (wsFailCount < maxWebSocketAttempts)
    {
        SetReferenceId("WS" + std::to_string(wsFailCount + 1));

        connectWebSocket(GetReferenceId());
        watchWebSocketStatus();   // <— panggil di sini tiap kali connect

        delay(2000);
        if (ws.available())
        {
            LogInfo(GetReferenceId(), "✅ WebSocket connected successfully");
            isDisableLoop = false;
            return;
        }

        wsFailCount++;
        ws.close();
        LogWarning(GetReferenceId(), "WebSocket connection failed, retrying...");
    }

    // Kalau 3x gagal
    LogError(GetReferenceId(), "❌ WebSocket repeatedly failed. Reopening WiFi Manager...");
    WiFi.disconnect(true);
    delay(1000);
    startupFlow();
}

void startupFlow()
{
    SetReferenceId("SETUP");
    LogInfo(GetReferenceId(), "---- STARTING DEVICE -----");

    startWiFiAndGetDeviceData();
    tryConnectWebSocket();

    isDisableLoop = false;
    isConnectedToWifi = true;

    LogInfo(GetReferenceId(), "✅ Startup successful!");
}

void onWiFiDisconnected(WiFiEvent_t event, WiFiEventInfo_t info)
{
    LogWarning("onWiFiDisconnected", " - WIFI DISCONNECTED!!!");
    isConnectedToWifi = false;
    isDisableLoop = true;
};

void onWiFiConnected(WiFiEvent_t event, WiFiEventInfo_t info)
{
    LogDebug("onWiFiConnected", " - WIFI IS CONNECTED!!!");
    LogDebug("onWiFiConnected", "IP ADD : ", std::string(WiFi.localIP().toString().c_str()));
    isConnectedToWifi = true;
    isDisableLoop = false;
}

void onWebSocketOpen()
{
    std::string referenceId = generateRandStr(8);
    LogInfo(referenceId, "WEBSOCKET - Connection opened");
    isDisableLoop = false;
}

void onWebSocketClose()
{
    static int wsFailCount = 0;
    wsFailCount++;

    std::string referenceId = generateRandStr(8);
    LogWarning(referenceId, "WEBSOCKET - Connection closed");
    isDisableLoop = true;

    if (wsFailCount >= 3)
    {
        LogError(referenceId, "❌ WebSocket repeatedly failed. Reopening WiFi Manager...");
        wsFailCount = 0;
        WiFi.disconnect(true);
        delay(1000);
        startupFlow();
    }
}

void setup()
{
    const int baudRate = 115200;
    Serial.begin(baudRate);
    delay(1000);
    WiFi.onEvent(onWiFiConnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_GOT_IP);
    WiFi.onEvent(onWiFiDisconnected);
    startupFlow();

    if (WiFi.status() == WL_CONNECTED)
    {
        isConnectedToWifi = true;
    }

    LogDebug(GetReferenceId(), "SETUP COMPLETED. IsDisableLoop: " + std::to_string(isDisableLoop));
    LogDebug(GetReferenceId(), "isConnectedToWifi: " + std::to_string(isConnectedToWifi));
};

unsigned long currentMillis = millis();
unsigned long previousMillis = 0;

static const unsigned long PING_INTERVAL = 5000;
static unsigned long lastPingMillis = 0;
void loop()
{
    if (!isDisableLoop && isConnectedToWifi)
    {


        unsigned long now = millis();

        // 1) Kirim ping secara periodik
        if (ws.available() && now - lastPingMillis >= PING_INTERVAL) {
            lastPingMillis = now;
    
            // Bangun pesan ping
            StaticJsonDocument<128> pingDoc;
            pingDoc["type"] = "ping";
            pingDoc["device_id"] = GetDeviceId();

            LogDebug(GetReferenceId(), "WEBSOCKET - Sending ping");
    
            std::string pingPayload;
            serializeJson(pingDoc, pingPayload);
    
            ws.send(pingPayload.c_str());
            LogDebug(GetReferenceId(), "WEBSOCKET - Sent ping");
        }


        ws.poll();

        currentMillis = millis();

        if (currentMillis - previousMillis >= GetReadInterval())
        {
            previousMillis = currentMillis;
            SetReferenceId(generateRandStr(8));

            LogDebug(GetReferenceId(), "===== Generated reference id: " + GetReferenceId() + " =====");
            LogDebug(GetReferenceId(), "Free heap: " + std::string(String(ESP.getFreeHeap()).c_str()) + " byte");

            bool isDataValid = readPzem004T(GetReferenceId());
            if (isDataValid)
            {
                LogInfo(GetReferenceId(),  "Sensor data is valid, send to server: ");
                if (ws.available())
                {
                    LogInfo(GetReferenceId(), "Sending sensor data to server...");
                    sendSensorData(GetReferenceId());
                }
                else
                {   
                    LogWarning(GetReferenceId(), "WebSocket not available, cannot send data");
                    tryConnectWebSocket();
                }
            }
        }
        else
        {
            delay(1000);
        }
    }
}