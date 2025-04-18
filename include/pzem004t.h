/**
 * @file sensors/readSensorData.h
 */

#ifndef READ_SENSOR_DATA_H
#define READ_SENSOR_DATA_H

#include <string>

/**
 * Membaca data dari sensor PZEM004T v3.0 dan menyimpannya ke variabel global `sensorData`.
 *
 * @param referenceId ID referensi untuk logging.
 * @return true jika pembacaan berhasil dan data valid, false jika gagal.
 */
bool readPzem004T(const std::string &referenceId);

#endif // READ_SENSOR_DATA_H
