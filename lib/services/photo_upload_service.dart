import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Hasil upload foto ke Supabase Storage.
class PhotoUploadResult {
  const PhotoUploadResult({required this.storagePath, required this.publicUrl});
  final String storagePath;
  final String publicUrl;
}

/// Layanan upload foto ke Supabase Storage (mode pengayaan).
/// Hanya dipanggil jika CloudConfig.enabled == true.
class PhotoUploadService {
  static const _bucket = 'kosfinder-ws10-demo';

  Future<PhotoUploadResult> upload(File file) async {
    final supabase = Supabase.instance.client;

    // 1. Pastikan ada sesi (anonymous sign-in jika belum).
    if (supabase.auth.currentSession == null) {
      await supabase.auth.signInAnonymously();
    }

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('Gagal mendapatkan user anonymous.');
    }

    // 2. Nama objek selalu di folder auth.uid() user.
    final ext = file.path.split('.').last.toLowerCase();
    final contentType = ext == 'png' ? 'image/png' : 'image/jpeg';
    final objectPath =
        '$userId/${DateTime.now().microsecondsSinceEpoch}.$ext';

    // 3. Upload file.
    await supabase.storage.from(_bucket).upload(
          objectPath,
          file,
          fileOptions: FileOptions(
            contentType: contentType,
            upsert: false,
          ),
        );

    // 4. Ambil public URL.
    final publicUrl =
        supabase.storage.from(_bucket).getPublicUrl(objectPath);

    return PhotoUploadResult(
      storagePath: objectPath,
      publicUrl: publicUrl,
    );
  }
}