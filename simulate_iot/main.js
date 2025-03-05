const WebSocket = require('ws');

// URL WebSocket yang dituju
const url = 'ws://localhost:5001/device-connect?name=device_j&password=qwerqwer';

// Membuat koneksi WebSocket
const ws = new WebSocket(url);

// Fungsi untuk mengirim data sensor
const sendSensorData = () => {
    const timestamp = new Date().toISOString(); // Gunakan format TIMESTAMPTZ (ISO 8601)

    console.log("Timestamp (TIMESTAMPTZ):", timestamp);

    const sensorData = {
        Tstamp: timestamp, // Kirim timestamp dalam format TIMESTAMPTZ
        Voltage: Math.random() * 10 + 210, 
        Current: Math.random() * 2 + 2, 
        Power: Math.random() * 100 + 500, 
        Energy: Math.random() * 1000 + 1000, 
        Frequency: Math.random() * 5 + 45, 
        Power_factor: Math.random() * 0.1 + 0.9 
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

    // Kirim data setiap 500 milidetik
    setInterval(sendSensorData, 500);
});

// Menangani error WebSocket
ws.on('error', (error) => {
    console.log('WebSocket error:', error);
});

// Menangani penutupan WebSocket
ws.on('close', () => {
    console.log('WebSocket connection closed');
});

