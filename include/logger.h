#ifndef LOGGER_H
#define LOGGER_H

#include <string>

enum LogLevel {
    LOG_ERROR,
    LOG_WARNING,
    LOG_EVENT,
    LOG_INFO,
    LOG_DEBUG
};

// Setter log level
void SetLogLevel(LogLevel level);

// Log function
/* void LogDebug(const std::string& id, const std::string& message);
void LogInfo(const std::string& id, const std::string& message);
void LogWarning(const std::string& id, const std::string& message);
void LogError(const std::string& id, const std::string& message);
 */

void LogDebug(const std::string &id, const std::string &message, const std::string &value = "");
void LogInfo(const std::string &id, const std::string &message, const std::string &value = "");
void LogWarning(const std::string &id, const std::string &message, const std::string &value = "");
void LogError(const std::string &id, const std::string &message, const std::string &value = "");


#endif
