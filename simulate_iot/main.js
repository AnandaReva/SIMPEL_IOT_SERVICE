const WebSocket = require('ws');

// URL WebSocket yang dituju
const url = 'ws://localhost:5001/device-connect?name=device_j&password=qwerqwer';

// Membuat koneksi WebSocket
const ws = new WebSocket(url);

// Fungsi untuk mengirim data sensor
const sendSensorData = () => {
    const timestamp = Date.now(); // Menggunakan timestamp saat ini (epoch miliseconds)

    // Log timestamp dalam format lokal
    const localDate = new Date(timestamp);
    const localDateString = `${localDate.toLocaleDateString()} ${localDate.toLocaleTimeString()}`;
    console.log("Timestamp (Local Time):", localDateString);

    const sensorData = {
        Tstamp: timestamp, // Mengirim timestamp epoch milidetik
        Voltage: Math.random() * 10 + 210, // Randomkan nilai tegangan antara 210V - 220V
        Current: Math.random() * 2 + 2, // Randomkan nilai arus antara 2A - 4A
        Power: Math.random() * 100 + 500, // Randomkan nilai daya antara 500W - 600W
        Energy: Math.random() * 1000 + 1000, // Randomkan energi antara 1000Wh - 2000Wh
        Frequency: Math.random() * 5 + 45, // Randomkan frekuensi antara 45Hz - 50Hz
        Power_factor: Math.random() * 0.1 + 0.9 // Randomkan faktor daya antara 0.9 - 1
    };

    // Kirim data ke server WebSocket
    if (ws.readyState === WebSocket.OPEN) {
        ws.send(JSON.stringify(sensorData));
        console.log('Sent data:', sensorData);
    }
};

// Menunggu koneksi WebSocket terbuka
ws.on('open', () => {
    console.log('Connected to WebSocket server');

    // Kirim data setiap 30 milidetik
    setInterval(sendSensorData, 500); // Ganti interval menjadi 30 milidetik
});

// Menangani error WebSocket
ws.on('error', (error) => {
    console.log('WebSocket error:', error);
});

// Menangani penutupan WebSocket
ws.on('close', () => {
    console.log('WebSocket connection closed');
});
