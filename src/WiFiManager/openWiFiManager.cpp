/**
 * @file openWiFiManager/openWiFiManager.cpp
 * 
 */

#include "logger.h"
#include "globalVar.h"
#include <WiFiManager.h>

WiFiManagerParameter customDeviceName("device_name", "Device Name", "", 32);
WiFiManagerParameter customDevicePassword("device_password", "Device Password", "", 32);

void openWiFiManager(const std::string& referenceId)
{
    LogInfo(referenceId, "-------------------------------------");
    LogInfo(referenceId, "WIFI MANAGER OPENED");
    LogInfo(referenceId, "-------------------------------------");

    if (wm.getParametersCount() == 0)
    {
        wm.addParameter(&customDeviceName);
        wm.addParameter(&customDevicePassword);
    }

    if (!wm.startConfigPortal("SIMPEL DEVICE CONFIGURATION"))
    {
        LogError(referenceId, "openWiFiManager - Gagal masuk mode konfigurasi, restart ESP32...");
        delay(3000);
        ESP.restart();
    }

    // Ambil hasil konfigurasi dari openWiFiManager
    String ssid = WiFi.SSID();
    String password = WiFi.psk();
    String deviceName = customDeviceName.getValue();
    String devicePassword = customDevicePassword.getValue();

    // Cek validitas input
    if (ssid.isEmpty() || password.isEmpty() || deviceName.isEmpty() || devicePassword.isEmpty())
    {
        LogError(referenceId, "openWiFiManager - Konfigurasi tidak lengkap. Restarting device...");
        delay(3000);
        ESP.restart();
    }

    // Simpan ke global
    SetWifiSSID(ssid.c_str());
    SetWifiPassword(password.c_str());
    SetDeviceName(deviceName.c_str());
    SetDevicePassword(devicePassword.c_str());

    // Log hasil konfigurasi
    LogInfo(referenceId, "openWiFiManager - WiFi SSID: " + std::string(ssid.c_str()));
    LogInfo(referenceId, "openWiFiManager - WiFi Password: " + std::string(password.c_str()));
    LogInfo(referenceId, "openWiFiManager - Device Name: " + std::string(deviceName.c_str()));
    LogInfo(referenceId, "openWiFiManager - Device Password: " + std::string(devicePassword.c_str()));
}
