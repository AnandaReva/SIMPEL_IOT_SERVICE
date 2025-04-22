/**
 * @file sendSensorData.h

 *
 */

#include <string>

/**
 * Membaca data dari sensor PZEM004T v3.0 dan menyimpannya ke variabel global `sensorData`.
 *
 * @param referenceId ID referensi untuk logging.
 * @return true jika pembacaan berhasil dan data valid, false jika gagal.
 */
bool readPzem004T(const std::string &referenceId);

#ifndef SEND_SENSOR_DATA_H
#define SEND_SENSOR_DATA_H

#include <string>

/**
 * @brief Mengirim data sensor melalui WebSocket ke backend.
 *
 * Fungsi ini membungkus data sensor ke dalam format JSON dan mengirimkannya
 * menggunakan koneksi WebSocket yang sudah diinisialisasi.
 *
 * @param referenceId ID referensi untuk logging.
 */
void sendSensorData(const std::string &referenceId);

#endif // SEND_SENSOR_DATA_H
