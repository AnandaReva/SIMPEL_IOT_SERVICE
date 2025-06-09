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


 🔄 Device Data Update via WebSocket
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


                LED RULES
                When startup and RED LED
                NOT connected to WiFi:
                → Turn on RED LED BLINKING
                WHEN connected WIFI SSID, password and device creds inputted but fail wheter its wifi or Server: BLINKING RED
                WHEN connected to WiFi and Server: TURN ON BLUE LED
                WHEN connected to WiFi but NOT connected to Server: BLINKING BLUE


                PUSH BUTTON RULES
                When push button pressed short time: Reset device and wifi data, then open WiFi Manager
                When push button pressed very long time: shutdown device and erase all data
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

// Function prototypes
void onWebSocketOpen();
void onWebSocketClose();
void startupFlow();

void ResetWiFiAndDeviceCredentials();
//////////////////////////////////////
enum LEDState
{
    RED_BLINK,
    RED_ON,
    BLUE_BLINK,
    BLUE_ON,
    LED_OFF
};

unsigned long lastLEDToggleTime = 0;

void updateLEDState()
{
    GlobalVar &gv = GlobalVar::Instance();

    if (!WiFi.isConnected())
    {
        gv.SetRedLEDStatus(1);  // BLINK
        gv.SetBlueLEDStatus(0); // OFF
    }
    else if (WiFi.isConnected() && (gv.GetDeviceId() == 0))
    {
        gv.SetRedLEDStatus(1);  // BLINK
        gv.SetBlueLEDStatus(0); // OFF
    }
    else if (WiFi.isConnected() && gv.GetDeviceId() > 0 && gv.ws.available())
    {
        gv.SetRedLEDStatus(0);  // OFF
        gv.SetBlueLEDStatus(2); // ON
    }
    else if (WiFi.isConnected() && gv.GetDeviceId() > 0 && !gv.ws.available())
    {
        gv.SetRedLEDStatus(0);  // OFF
        gv.SetBlueLEDStatus(1); // BLINK
    }
    else
    {
        gv.SetRedLEDStatus(0);  // OFF
        gv.SetBlueLEDStatus(0); // OFF
    }
}

void handleLED()
{
    GlobalVar &gv = GlobalVar::Instance();
    unsigned long now = millis();

    int redStatus = gv.GetRedLEDStatus();   // 0: OFF, 1: BLINK, 2: ON
    int blueStatus = gv.GetBlueLEDStatus(); // 0: OFF, 1: BLINK, 2: ON
    int blinkInterval = gv.GetLEDBlinkInterval();

    static unsigned long lastToggle = 0;

    if (now - lastToggle >= blinkInterval)
    {
        lastToggle = now;
        // Blink status updated here only for logical tracking, but LED will remain ON
    }

    // RED LED: Always ON if blinking or solid
    if (redStatus == 0)
        digitalWrite(RED_LED_PIN, LOW);
    else
        digitalWrite(RED_LED_PIN, HIGH); // Always HIGH

    // BLUE LED: Always ON if blinking or solid
    if (blueStatus == 0)
        digitalWrite(BLUE_LED_PIN, LOW);
    else
        digitalWrite(BLUE_LED_PIN, HIGH); // Always HIGH
}



unsigned long buttonPressStartTime = 0;
unsigned long lastButtonChangeTime = 0;
bool buttonWasPressed = false;
const unsigned long debounceDelay = 50; // 50 ms debounce

void handlePushButton()
{
    static int lastButtonState = HIGH;
    int currentButtonState = digitalRead(PUSH_BUTTON_PIN);
    unsigned long currentMillis = millis();

    if (currentButtonState != lastButtonState)
    {
        lastButtonChangeTime = currentMillis;
        lastButtonState = currentButtonState;
    }

    if ((currentMillis - lastButtonChangeTime) > debounceDelay)
    {
        // Tombol ditekan (aktif LOW)
        if (currentButtonState == LOW && !buttonWasPressed)
        {
            buttonWasPressed = true;
            buttonPressStartTime = currentMillis;
        }
        // Tombol dilepas
        else if (currentButtonState == HIGH && buttonWasPressed)
        {
            buttonWasPressed = false;
            unsigned long pressDuration = currentMillis - buttonPressStartTime;

            if (pressDuration >= 10000)
            {
                LogInfo("BUTTON", "Long press detected. Erasing ALL settings and restarting...");
                WiFi.disconnect(true);
                delay(500);
                ESP.restart();
            }
            else if (pressDuration >= 500)
            {
                LogInfo("BUTTON", "Short press detected. Resetting WiFi and opening WiFiManager...");
                ResetWiFiAndDeviceCredentials();
                startupFlow();
            }
        }
    }
}

///////////////// ERASE CONFIG /////////////////////

void ResetWiFiAndDeviceCredentials()
{
    GlobalVar &gv = GlobalVar::Instance();

    LogInfo(gv.GetReferenceId(), "Resertting WiFi configuration...");
    WiFi.disconnect(true);
    delay(500);
    gv.SetWifiSSID("");
    gv.SetWifiPassword("");
    gv.SetDeviceId(0);
    gv.SetDeviceName("");
    gv.SetDevicePassword("");
    gv.SetReadInterval(1000); // Set default read interval
    gv.SetIsLoopDisabled(true);
    gv.SetIsConnectedToWifi(false);
    gv.ws.close();         // Close WebSocket connection if open
    gv.pzem.resetEnergy(); // Reset PZEM004T energy data
    gv.SetLastEnergy(0.0);
    gv.SetLastResetMonth(""); // Reset last reset month

    LogInfo(gv.GetReferenceId(), "WiFi and Device credentials successfully reset\ted.");
}

//////////////////////////////////////

void watchWebSocketStatus()
{
    GlobalVar &gv = GlobalVar::Instance();

    gv.ws.onEvent([](websockets::WebsocketsEvent event, String data)
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

    GlobalVar &gv = GlobalVar::Instance();

    while (startupAttempt < maxStartupAttempts)
    {
        startupAttempt++;
        gv.SetReferenceId("SETUP");
        LogInfo(gv.GetReferenceId(), "Startup Attempt #" + std::to_string(startupAttempt));

        // Step 1: Buka WiFi Manager
        openWiFiManager(gv.GetReferenceId());

        // Step 2: Ambil data perangkat
        int getDataTryCount = 0;
        bool isDataReceived = false;

        while (getDataTryCount < maxGetDataAttempts)
        {
            getDataTryCount++;
            LogInfo(gv.GetReferenceId(), "Trying to get device data... Attempt #" + std::to_string(getDataTryCount));
            delay(2000);

            isDataReceived = getDeviceData(gv.GetReferenceId());
            if (isDataReceived)
                break;
        }

        if (isDataReceived)
        {
            LogInfo(gv.GetReferenceId(), "✅ Device data retrieved successfully");
            return; // Lanjut ke WebSocket
        }

        LogError(gv.GetReferenceId(), "❌ Failed to get device data. Reopening WiFi Manager...");
        WiFi.disconnect(true); // Reset koneksi WiFi
        delay(1000);
    }

    LogError(gv.GetReferenceId(), "❌ All startup attempts failed. Restarting device...");
    ESP.restart();
}

void tryConnectWebSocket()
{
    const int maxWebSocketAttempts = 3;
    int wsFailCount = 0;

    GlobalVar &gv = GlobalVar::Instance();

    while (wsFailCount < maxWebSocketAttempts)
    {
        gv.SetReferenceId("WS" + std::to_string(wsFailCount + 1));

        connectWebSocket(gv.GetReferenceId());
        watchWebSocketStatus(); // <— panggil di sini tiap kali connect

        delay(2000);
        if (gv.ws.available())
        {
            LogInfo(gv.GetReferenceId(), "✅ WebSocket connected successfully");
            gv.SetIsLoopDisabled(false);
            return;
        }

        wsFailCount++;
        gv.ws.close();
        LogWarning(gv.GetReferenceId(), "WebSocket connection failed, retrying...");
    }

    // Kalau 3x gagal
    LogError(gv.GetReferenceId(), "❌ WebSocket repeatedly failed. Reopening WiFi Manager...");
    WiFi.disconnect(true);
    delay(1000);
    startupFlow();
}

void startupFlow()
{
    GlobalVar &gv = GlobalVar::Instance();

    gv.SetReferenceId("SETUP");
    LogInfo(gv.GetReferenceId(), "---- STARTING DEVICE -----");

    startWiFiAndGetDeviceData();
    tryConnectWebSocket();

    gv.SetIsLoopDisabled(false);
    gv.SetIsConnectedToWifi(true);

    LogInfo(gv.GetReferenceId(), "✅ Startup successful!");
    updateLEDState();
    handleLED();
}

void onWiFiDisconnected(WiFiEvent_t event, WiFiEventInfo_t info)
{
    GlobalVar &gv = GlobalVar::Instance();

    LogWarning("onWiFiDisconnected", " - WIFI DISCONNECTED!!!");
    gv.SetIsLoopDisabled(false);
    gv.SetIsConnectedToWifi(true);
};

void onWiFiConnected(WiFiEvent_t event, WiFiEventInfo_t info)
{
    GlobalVar &gv = GlobalVar::Instance();

    LogDebug("onWiFiConnected", " - WIFI IS CONNECTED!!!");
    LogDebug("onWiFiConnected", "IP ADD : ", std::string(WiFi.localIP().toString().c_str()));

    gv.SetIsLoopDisabled(false);
    gv.SetIsConnectedToWifi(true);
}

void onWebSocketOpen()
{
    GlobalVar &gv = GlobalVar::Instance();

    std::string referenceId = generateRandStr(8);
    LogInfo(referenceId, "WEBSOCKET - Connection opened");
    gv.SetIsLoopDisabled(false);
}

void onWebSocketClose()
{

    static int wsFailCount = 0;
    wsFailCount++;

    GlobalVar &gv = GlobalVar::Instance();

    std::string referenceId = generateRandStr(8);
    LogWarning(referenceId, "WEBSOCKET - Connection closed");
    gv.SetIsLoopDisabled(true);

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

    GlobalVar &gv = GlobalVar::Instance();

    delay(1000);
    WiFi.onEvent(onWiFiConnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_GOT_IP);
    WiFi.onEvent(onWiFiDisconnected);

    updateLEDState(); // <--- Tambahkan ini
    handleLED();      // <--- Tambahkan ini

    startupFlow();

    if (WiFi.status() == WL_CONNECTED)
    {
        gv.SetIsConnectedToWifi(true);
    }

    LogDebug(gv.GetReferenceId(), "SETUP COMPLETED. IsDisableLoop: " + std::to_string(gv.GetIsLoopDisabled()));
    LogDebug(gv.GetReferenceId(), "isConnectedToWifi: " + std::to_string(gv.GetIsConnectedToWifi()));
};

unsigned long currentMillis = millis();
unsigned long previousMillis = 0;

static const unsigned long PING_INTERVAL = 5000;
static unsigned long lastPingMillis = 0;
void loop()
{
    GlobalVar &gv = GlobalVar::Instance();

    updateLEDState();
    handleLED();
    handlePushButton();

    if (!gv.GetIsLoopDisabled() && gv.GetIsConnectedToWifi())
    {

        unsigned long now = millis();

        // 1) Kirim ping secara periodik
        if (gv.ws.available() && now - lastPingMillis >= PING_INTERVAL)
        {
            lastPingMillis = now;

            // Bangun pesan ping
            StaticJsonDocument<128> pingDoc;
            pingDoc["type"] = "ping";
            pingDoc["device_id"] = gv.GetDeviceId();

            LogDebug(gv.GetReferenceId(), "WEBSOCKET - Sending ping");

            std::string pingPayload;
            serializeJson(pingDoc, pingPayload);

            gv.ws.send(pingPayload.c_str());
            LogDebug(gv.GetReferenceId(), "WEBSOCKET - Sent ping");
        }

        gv.ws.poll();

        currentMillis = millis();

        if (currentMillis - previousMillis >= gv.GetReadInterval())
        {
            previousMillis = currentMillis;
            gv.SetReferenceId(generateRandStr(8));

            LogDebug(gv.GetReferenceId(), "===== Generated reference id: " + gv.GetReferenceId() + " =====");
            LogDebug(gv.GetReferenceId(), "Free heap: " + std::string(String(ESP.getFreeHeap()).c_str()) + " byte");

            bool isDataValid = readPzem004T(gv.GetReferenceId());
            if (isDataValid)
            {
                LogInfo(gv.GetReferenceId(), "Sensor data is valid, send to server: ");
                if (gv.ws.available())
                {
                    LogInfo(gv.GetReferenceId(), "Sending sensor data to server...");
                    sendSensorData(gv.GetReferenceId());
                }
                else
                {
                    LogWarning(gv.GetReferenceId(), "WebSocket not available, cannot send data");
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

void updateDevice()
{
    int updateTryCount = 0;
    GlobalVar &gv = GlobalVar::Instance();

    // stop loop

    gv.SetIsLoopDisabled(true);

    LogInfo(gv.GetReferenceId(), "updateDevice - Updating device data...");

    bool isScuess = getDeviceData(gv.GetReferenceId());
    if (isScuess)
    {
        LogInfo(gv.GetReferenceId(), "updateDevice - Device data updated successfully");
    }
    else
    {
        while (updateTryCount < 3)
        {
            updateTryCount++;
            LogInfo(gv.GetReferenceId(), "updateDevice - Trying to update device data... Attempt #" + std::to_string(updateTryCount));
            delay(2000); // Delay antara percobaan ulang

            isScuess = getDeviceData(gv.GetReferenceId());
            if (isScuess)
            {
                LogInfo(gv.GetReferenceId(), "updateDevice - Device data updated successfully after retry #" + std::to_string(updateTryCount));
                break;
            }
        }

        if (!isScuess) // Hanya log error jika masih gagal setelah 3 kali percobaan
        {
            LogError(gv.GetReferenceId(), "updateDevice - Failed to update device data after 3 attempts");
        }

        // Jika gagal, jalankan startupFlow()
        startupFlow();
    }
}
