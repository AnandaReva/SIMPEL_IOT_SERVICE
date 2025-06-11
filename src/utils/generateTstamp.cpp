/**
 * @file utils/generateTstamp.cpp
 *
 *
 * exp call: utils.GetTstamp();
 */

#include "generateTstamp.h"

#include <chrono>
#include <ctime>
#include <iomanip>
#include <sstream>

std::string generateTstamp()
{
  auto now = std::chrono::system_clock::now();
  std::time_t now_time_t = std::chrono::system_clock::to_time_t(now);

  // Cek jika waktu lebih kecil dari 1 Jan 2000 (946684800 epoch time)
  if (now_time_t < 946684800)
  {
    return ""; // Waktu tidak valid (kemungkinan belum sinkron)
  }

  // UTC
  std::tm *tm = std::gmtime(&now_time_t);
  std::stringstream ss;
  ss << std::put_time(tm, "%Y-%m-%d %H:%M:%S");

  return ss.str();
}


