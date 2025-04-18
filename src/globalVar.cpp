/**
 * @file globalVar.cpp
 * exp call:    SetDeviceName("UpdatedNode");
 *              String(GetDeviceName().c_str())
 */

#include "globalVar.h"
#include <WiFiManager.h>
#include <ArduinoWebsockets.h> // Ensure this library is installed
#include <PZEM004Tv30.h>

#include <string>
#include <HTTPClient.h>

std::string appName = "SIMPEL_DEVICE_SC";
std::string appVersion = "0.1.1";

std::string serverUrl = "http://10.4.157.103:5001";
std::string websocketUrl = "ws://10.4.157.103:5001/device-connect";

/* deiveId, deviceName , devicePassword, WiFiSsid, WiFIPassword, readInterval */
DeviceInfo deviceInfo = {0, "", "", "", "", 0};

/* power energy, voltage , current, frequency, powerFactor */
SensorData sensorData = {0, 0, 0, 0, 0, 0, ""};

std::string referenceId = "";

// global Insctance
/* ----- PIN */
HardwareSerial serial(2); // UART2
/* ----- INSTANCE */
WiFiManager wm;
HTTPClient http;
websockets::WebsocketsClient ws;
PZEM004Tv30 pzem(serial, PZEM_RX_PIN, PZEM_TX_PIN);

/**
 * @brief GETTER FUNCTIONS
 *
 */

std::string GetReferenceId()
{
    return referenceId;
}

std::string GetAppName()
{
    return appName;
}
std::string GetAppVersion()
{
    return appVersion;
}
std::string GetServerUrl()
{
    return serverUrl;
}
std::string GetWebsocketUrl()
{
    return websocketUrl;
}
/* --------- DEVICE INFO ---------- */
std::string GetDevicePassword()
{
    return deviceInfo.devicePassword;
}
std::string GetDeviceName()
{
    return deviceInfo.deviceName;
}

std::string GetWifiSSID()
{
    return deviceInfo.wifiSsid;
}
std::string GetWifiPassword()
{
    return deviceInfo.wifiPassword;
}
unsigned long GetReadInterval()
{
    return deviceInfo.readInterval;
}

/* --------- SENSOR DATA ---------- */
float GetPower()
{
    return sensorData.power;
};
float GetEnergy()
{
    return sensorData.energy;
};
float GetVoltage()
{
    return sensorData.voltage;
};
float GetCurrent()
{
    return sensorData.current;
};
float GetFrequency()
{
    return sensorData.frequency;
};
float GetPowerFactor()
{
    return sensorData.powerFactor;
};
std::string GetReadTstamp()
{
    return sensorData.readTstamp;
};

/**
 * @brief SETTER FUNCTIONS
 *
 */

void SetReferenceId(const std::string &referenceId)
{
}
/* --------- DEVICE INFO ---------- */
void SetDeviceName(const std::string &name)
{
    deviceInfo.deviceName = name;
}
void SetDevicePassword(const std::string &devicePassword)
{
    deviceInfo.devicePassword = devicePassword;
}
void SetWifiSSID(const std::string &ssid)
{
    deviceInfo.wifiSsid = ssid;
}
void SetWifiPassword(const std::string &password)
{
    deviceInfo.wifiPassword = password;
}

void SetReadInterval(unsigned long interval)
{
    deviceInfo.readInterval = interval;
}

/* --------- SENSOR DATA ---------- */
void SetPower(float power)
{
    sensorData.power = power;
};
void SetEnergy(float energy)
{
    sensorData.energy = energy;
}
void SetVoltage(float voltage)
{
    sensorData.voltage = voltage;
};
void SetCurrent(float current)
{
    sensorData.current = current;
};
void SetFrequency(float frequency)
{
    sensorData.frequency = frequency;
}
void SetPowerFactor(float powerFactor)
{
    sensorData.powerFactor = powerFactor;
};
void SetReadTstamp(float readTstamp)
{
    sensorData.readTstamp = readTstamp;
};
