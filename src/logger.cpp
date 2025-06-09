/**
 * @file logger.cpp
 *
 * exp call: LogInfo("INIT", "Inisialisasi selesai");
 * exp output : 2025-04-12T10:01:22.123456789+07:00 - SIMPEL_DEVICE_SC - VERSION: 0.1.1 - BOOT - DEBUG - Memulai perangkat
 */

#include "logger.h"
#include "globalVar.h"
#include <generateTstamp.h>

#include <iostream>
#include <ctime>
#include <sstream>

using namespace std;

LogLevel currentLogLevel = LOG_DEBUG;

void SetLogLevel(LogLevel level)
{
    currentLogLevel = level;
}

string GetPrefix(const string &level, const string &id)
{
    GlobalVar &gv = GlobalVar::Instance();
    stringstream ss;
    ss << generateTstamp()
       << " - " << gv.GetAppName()
       << " - VERSION: " << gv.GetAppVersion()
       << " - " << id << " - " << level << " - ";
    return ss.str();
}

void LogDebug(const string &id, const string &message, const string &value)
{
    if (currentLogLevel >= LOG_DEBUG)
    {
        cout << GetPrefix("DEBUG", id) << message;
        if (!value.empty())
            cout << " | " << value;
        cout << endl;
    }
}

void LogInfo(const string &id, const string &message, const string &value)
{
    if (currentLogLevel >= LOG_INFO)
    {
        cout << GetPrefix("INFO", id) << message;
        if (!value.empty())
            cout << " | " << value;
        cout << endl;
    }
}

void LogWarning(const string &id, const string &message, const string &value)
{
    if (currentLogLevel >= LOG_WARNING)
    {
        cout << GetPrefix("WARNING", id) << message;
        if (!value.empty())
            cout << " | " << value;
        cout << endl;
    }
}

void LogError(const string &id, const string &message, const string &value)
{
    if (currentLogLevel >= LOG_ERROR)
    {
        cout << GetPrefix("ERROR", id) << message;
        if (!value.empty())
            cout << " | " << value;
        cout << endl;
    }
}
