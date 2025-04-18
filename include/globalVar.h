/**
 * @file globalVar.h
 *
 */
#ifndef APP_INFO_H
#define APP_INFO_H

#include <string>
#include <WiFiManager.h>
#include <ArduinoWebsockets.h>
#include <PZEM004Tv30.h>
#include <HTTPClient.h>


extern std::string referenceId;
extern std::string appName;
extern std::string appVersion;
extern std::string serverUrl;
extern std::string websocketUrl;

struct DeviceInfo
{
    unsigned long deviceId;
    std::string deviceName;
    std::string devicePassword;
    std::string wifiSsid;
    std::string wifiPassword;
    unsigned long readInterval;
};

struct SensorData
{
    float power;
    float energy;
    float voltage;
    float current;
    float frequency;
    float powerFactor;
    std::string readTstamp;
};

// instance

// instance
extern WiFiManager wm;
extern HTTPClient http;
extern websockets::WebsocketsClient ws;
extern HardwareSerial serial;
extern PZEM004Tv30 pzem;
// pin consts
#define PZEM_RX_PIN 25
#define PZEM_TX_PIN 26


std::string GetAppName();
std::string GetAppVersion();
std::string GetServerUrl();
std::string GetWebsocketUrl();

// Deklarasi global variable (didefinisikan di .cpp)
extern DeviceInfo deviceInfo;

extern SensorData sensorData;

// Getter
std::string GetReferenceId();
std::string GetAppName();
std::string GetAppVersion();

std::string GetDeviceName();
std::string GetDevicePassword();
std::string GetWifiSSID();
std::string GetWifiPassword();
unsigned long GetReadInterval();

float GetPower();
float GetEnergy();
float GetVoltage();
float GetCurrent();
float GetFrequency();
float GetPowerFactor();
std::string GetReadTstamp();

// Setter
void SetReferenceId(const std::string &);
void SetDeviceName(const std::string &);
void SetDevicePassword(const std::string &);
void SetWifiSSID(const std::string &); 
void SetWifiPassword(const std::string &); 
void SetReadInterval(unsigned long);
void SetReadTstamp(std::string);

void SetPower(float);
void SetEnergy(float);
void SetVoltage(float);
void SetCurrent(float);
void SetFrequency(float);
void SetPowerFactor(float);

#endif
