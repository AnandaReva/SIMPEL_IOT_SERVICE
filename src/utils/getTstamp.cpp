/**
 * @file utils/generateTstamp.cpp
 *
 * @return String
 *
 * exp call: utils.GetTstamp();
 */

#include "getTstamp.h"
#include <TimeLib.h> // for: year(), month(), etc.
#include <NTPClient.h>
#include <WiFiUdp.h>

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 7 * 3600, 60000); // +7 GMT

String getTstamp()
{
  timeClient.update();
  time_t epochTime = timeClient.getEpochTime();

  char buffer[25];
  snprintf(buffer, sizeof(buffer), "%04d-%02d-%02d %02d:%02d:%02d",
           year(epochTime), month(epochTime), day(epochTime),
           hour(epochTime), minute(epochTime), second(epochTime));

  return String(buffer);
}
