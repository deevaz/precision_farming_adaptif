import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  // Warna Utama (Branding)
  static const Color primary = Color(0xFF10B981); // Emerald Growth (Utama)
  static const Color secondary = Color(0xFF3B82F6); // IoT Blue (Teknologi/Data)
  static const Color accent = Color(0xFF064E3B); // Deep Forest (Kontras)

  // Status & Notifikasi (Paprika Based)
  static const Color success = Color(0xFF10B981); // Hijau (Aman/Normal)
  static const Color danger = Color(0xFFEF4444); // Paprika Red (Alert/Error)
  static const Color warning = Color(
    0xFFF59E0B,
  ); // Sun Yellow (Warning/Nutrisi)
  static const Color info = Color(0xFF0EA5E9); // Sky Blue (Informasi Umum)

  // Permukaan & Latar Belakang (Neutral)
  // Di AppStyle kamu, ubah bagian light:
  static const Color light = Color(0xFFF1F5F9);
  static const Color dark = Color(0xFF0F172A); // Rich Navy (Dark Mode/OLED)
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF64748B); // Slate Grey (Text Body)

  // Warna tambahan untuk variasi UI
  static const Color surface = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0);
}
