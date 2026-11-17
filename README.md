# KosFinder Device Demo (Worksheet 10)

Aplikasi Flutter standalone yang dibuat untuk memenuhi Worksheet 10 - Advanced Mobile Features & Device Integration. Aplikasi ini mendemonstrasikan integrasi perangkat keras (kamera, GPS, sensor) dan penyimpanan data lokal maupun cloud.

## 🚀 Fitur Utama

### Fitur Wajib
- **Kamera & Galeri:** Mengambil foto menggunakan `image_picker` dan menyalinnya secara permanen ke direktori dokumen aplikasi (bukan sekadar cache).
- **GPS & Runtime Permission:** Mengambil koordinat lokasi dengan penanganan izin yang komprehensif (izin ditolak, GPS mati, *timeout*) menggunakan `geolocator`.
- **Draft Lokal:** Menyimpan metadata (nama kos, path foto, koordinat) secara lokal menggunakan `shared_preferences`. Draft tetap ada meskipun aplikasi ditutup atau di-restart.

### Fitur Pengayaan (Opsional)
- **Supabase Storage:** Mengunggah foto ke cloud storage menggunakan *anonymous sign-in* dan *Row Level Security* (RLS) via `supabase_flutter`.
- **Sensor Accelerometer:** Mendemonstrasikan pembacaan data sensor gerak perangkat secara *real-time* menggunakan `sensors_plus`.

## 📸 Bukti Implementasi

| Mode Lokal | Kamera & GPS | Draft Tersimpan |
| :---: | :---: | :---: |
| <img src="docs/screenshots/01_mode_lokal.png" width="250"> | <img src="docs/screenshots/02_foto_gps.png" width="250"> | <img src="docs/screenshots/03_draft_restored.png" width="250"> |

| GPS Ditolak | GPS Mati | Upload Supabase | Sensor Accelerometer |
| :---: | :---: | :---: | :---: |
| <img src="docs/screenshots/04_gps_ditolak.png" width="200"> | <img src="docs/screenshots/05_gps_off.png" width="200"> | <img src="docs/screenshots/06_upload_supabase.png" width="200"> | <img src="docs/screenshots/07_sensor.png" width="200"> |

## 🛠️ Cara Menjalankan

### 1. Mode Lokal (Offline)
Aplikasi berjalan sepenuhnya offline tanpa memerlukan akun atau koneksi ke Supabase.
```bash
flutter pub get
flutter run
