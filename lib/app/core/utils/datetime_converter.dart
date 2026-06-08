import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null || json.isEmpty) return null;

    // 1. Parsing string dari PocketBase
    // PocketBase biasanya kasih format: 2026-04-05 18:00:00.000Z atau tanpa Z
    DateTime dt = DateTime.parse(json);

    // 2. CEK APAKAH INI DATA LAMA (Laravel) ATAU DATA BARU (PB Asli)
    // Data lama biasanya jamnya udah WIB tapi masuk ke PB tanpa offset
    // Data baru biasanya udah beneran UTC (ada Z di belakangnya)

    if (!json.contains('Z') && !json.contains('+')) {
      // Jika string tidak punya penanda timezone, asumsikan ini UTC mentah
      // Kita kembalikan sebagai waktu lokal
      return dt.toLocal();
    }

    // Jika sudah ada 'Z', DateTime.parse otomatis tau itu UTC, tinggal toLocal()
    return dt.toLocal();
  }

  @override
  String? toJson(DateTime? object) {
    // Saat simpan ke PocketBase, WAJIB toUtc() dan format bersih tanpa 'T'
    if (object == null) return null;
    return object
        .toUtc()
        .toIso8601String()
        .replaceFirst('T', ' ')
        .substring(0, 19);
  }
}
