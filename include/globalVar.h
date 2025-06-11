/**
 * @file globalVar.h
 *
 */
#ifndef GLOBAL_VAR_H
#define GLOBAL_VAR_H

#include <string>
#include <WiFiManager.h>
#include <ArduinoWebsockets.h>
#include <PZEM004Tv30.h>
#include <HTTPClient.h>

#define PZEM_RX_PIN 16 // RX2 devkit v1
#define PZEM_TX_PIN 17 // TX2 devkit v1

#define RED_LED_PIN 2
#define BLUE_LED_PIN 4


#define PUSH_BUTTON_PIN 15

// LED rule : 0 = off , 1 = on , 2 = blink
struct LEDInfo
{
    int blinkInterval;
    int RedLEDStatus ;  // 0 = off, 1 = on Solid , 2 = on blink
    int BlueLEDStatus; // 0 = off, 1 = on solid, 2 = blink
};

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
    double energy;
    float voltage;
    float current;
    float frequency;
    float powerFactor;
    std::string readTstamp;
};

class GlobalVar
{
public:
    static GlobalVar &Instance();

    // App Info
    std::string GetAppName() const;
    std::string GetAppVersion() const;
    std::string GetServerUrl() const;
    std::string GetWebsocketUrl() const;

    // Reference ID
    std::string GetReferenceId() const;
    void SetReferenceId(const std::string &);

    // LED Info
    int GetRedLEDStatus() const;
    int GetBlueLEDStatus() const;
    int GetLEDBlinkInterval() const;



    void SetRedLEDStatus(int status);
    void SetBlueLEDStatus(int status);

    // Device Info
    unsigned long GetDeviceId() const;
    std::string GetDeviceName() const;
    std::string GetDevicePassword() const;
    std::string GetWifiSSID() const;
    std::string GetWifiPassword() const;
    unsigned long GetReadInterval() const;

    void SetDeviceId(unsigned long);
    void SetDeviceName(const std::string &);
    void SetDevicePassword(const std::string &);
    void SetWifiSSID(const std::string &);
    void SetWifiPassword(const std::string &);
    void SetReadInterval(unsigned long);

    // Sensor Data
    float GetPower() const;
    double GetEnergy() const;
    float GetVoltage() const;
    float GetCurrent() const;
    float GetFrequency() const;
    float GetPowerFactor() const;
    std::string GetReadTstamp() const;

    void SetPower(float);
    void SetEnergy(double);
    void SetVoltage(float);
    void SetCurrent(float);
    void SetFrequency(float);
    void SetPowerFactor(float);
    void SetReadTstamp(const std::string &);

    // Misc
    double GetLastEnergy() const;
    void SetLastEnergy(double);

    std::string GetLastResetMonth() const;
    void SetLastResetMonth(const std::string &);

    bool GetIsLoopDisabled() const;
    void SetIsLoopDisabled(bool);

    bool GetIsConnectedToWifi() const;
    void SetIsConnectedToWifi(bool);

    // Hardware Instances
    WiFiManager wm;
    HTTPClient http;
    websockets::WebsocketsClient ws;
    HardwareSerial serial;
    PZEM004Tv30 pzem;

private:
    GlobalVar();
    GlobalVar(const GlobalVar &) = delete;
    GlobalVar &operator=(const GlobalVar &) = delete;

    std::string referenceId;
    std::string appName;
    std::string appVersion;
    std::string serverUrl;
    std::string websocketUrl;

    LEDInfo ledInfo;
    DeviceInfo deviceInfo;
    SensorData sensorData;

    double lastEnergy;
    std::string lastResetMonth;
    bool isLoopDisabled;
    bool isConnectedToWifi;
};

#endif


