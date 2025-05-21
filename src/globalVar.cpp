/**
 * @file globalVar.cpp
 * exp call:    SetDeviceName("UpdatedNode");
 *              String(GetDeviceName().c_str())
 */

#include "globalVar.h"

GlobalVar &GlobalVar::Instance()
{
    static GlobalVar instance;
    return instance;
}

GlobalVar::GlobalVar()
    : appName("SIMPEL_DEVICE_SC"),
      appVersion("0.2.3"),
      serverUrl("http://10.4.157.103:5001"),
      websocketUrl("ws://10.4.157.103:5001/device-connect"),
      serial(2), // UART2
      pzem(serial, PZEM_RX_PIN, PZEM_TX_PIN),
      lastEnergy(0.0),
      isLoopDisabled(true),
      isConnectedToWifi(false)
{
    deviceInfo = {0, "", "", "", "", 0};
    sensorData = {0, 0, 0, 0, 0, 0, ""};
}

// App Info
std::string GlobalVar::GetAppName() const { return appName; }
std::string GlobalVar::GetAppVersion() const { return appVersion; }
std::string GlobalVar::GetServerUrl() const { return serverUrl; }
std::string GlobalVar::GetWebsocketUrl() const { return websocketUrl; }

// Reference ID
std::string GlobalVar::GetReferenceId() const { return referenceId; }
void GlobalVar::SetReferenceId(const std::string &ref) { referenceId = ref; }

// Device Info
unsigned long GlobalVar::GetDeviceId() const { return deviceInfo.deviceId; }
std::string GlobalVar::GetDeviceName() const { return deviceInfo.deviceName; }
std::string GlobalVar::GetDevicePassword() const { return deviceInfo.devicePassword; }
std::string GlobalVar::GetWifiSSID() const { return deviceInfo.wifiSsid; }
std::string GlobalVar::GetWifiPassword() const { return deviceInfo.wifiPassword; }
unsigned long GlobalVar::GetReadInterval() const { return deviceInfo.readInterval; }

void GlobalVar::SetDeviceId(unsigned long id) { deviceInfo.deviceId = id; }
void GlobalVar::SetDeviceName(const std::string &name) { deviceInfo.deviceName = name; }
void GlobalVar::SetDevicePassword(const std::string &pass) { deviceInfo.devicePassword = pass; }
void GlobalVar::SetWifiSSID(const std::string &ssid) { deviceInfo.wifiSsid = ssid; }
void GlobalVar::SetWifiPassword(const std::string &pwd) { deviceInfo.wifiPassword = pwd; }
void GlobalVar::SetReadInterval(unsigned long interval) { deviceInfo.readInterval = interval; }

// Sensor Data
float GlobalVar::GetPower() const { return sensorData.power; }
double GlobalVar::GetEnergy() const { return sensorData.energy; }
float GlobalVar::GetVoltage() const { return sensorData.voltage; }
float GlobalVar::GetCurrent() const { return sensorData.current; }
float GlobalVar::GetFrequency() const { return sensorData.frequency; }
float GlobalVar::GetPowerFactor() const { return sensorData.powerFactor; }
std::string GlobalVar::GetReadTstamp() const { return sensorData.readTstamp; }

void GlobalVar::SetPower(float v) { sensorData.power = v; }
void GlobalVar::SetEnergy(double v) { sensorData.energy = v; }
void GlobalVar::SetVoltage(float v) { sensorData.voltage = v; }
void GlobalVar::SetCurrent(float v) { sensorData.current = v; }
void GlobalVar::SetFrequency(float v) { sensorData.frequency = v; }
void GlobalVar::SetPowerFactor(float v) { sensorData.powerFactor = v; }
void GlobalVar::SetReadTstamp(const std::string &ts) { sensorData.readTstamp = ts; }

// Misc
double GlobalVar::GetLastEnergy() const { return lastEnergy; }
void GlobalVar::SetLastEnergy(double e) { lastEnergy = e; }

std::string GlobalVar::GetLastResetMonth() const { return lastResetMonth; }
void GlobalVar::SetLastResetMonth(const std::string &m) { lastResetMonth = m; }

bool GlobalVar::GetIsLoopDisabled() const { return isLoopDisabled; }
void GlobalVar::SetIsLoopDisabled(bool val) { isLoopDisabled = val; }

bool GlobalVar::GetIsConnectedToWifi() const { return isConnectedToWifi; }
void GlobalVar::SetIsConnectedToWifi(bool val) { isConnectedToWifi = val; }
