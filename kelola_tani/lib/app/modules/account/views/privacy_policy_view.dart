import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppStyle.primary,
        title: Text(
          'Kebijakan Privasi',
          style: AppFonts.lgSemiBold.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terakhir diperbarui: 28 Mei 2026',
              style: AppFonts.smRegular.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 20.h),

            _buildSection(
              title: '1. Informasi yang Kami Kumpulkan',
              content:
                  'Saat Anda menggunakan Kelola Tani, kami mengumpulkan informasi dasar untuk keperluan autentikasi dan fungsionalitas aplikasi. Karena menggunakan Google Sign-In, kami menerima informasi seperti:\n'
                  '• Nama akun Google\n'
                  '• Alamat Email\n'
                  '• Foto Profil\n'
                  'Selain itu, kami menyimpan data dari sensor atau alat IoT yang terhubung dengan akun Anda untuk keperluan monitoring lahan.',
            ),
            _buildSection(
              title: '2. Cara Kami Menggunakan Data',
              content:
                  'Data Anda sepenuhnya digunakan untuk:\n'
                  '• Mengidentifikasi akun dan sesi login Anda.\n'
                  '• Menampilkan status dan metrik alat secara real-time.\n'
                  '• Memastikan keamanan kontrol alat pertanian Anda dari akses pihak tidak berwenang.',
            ),
            _buildSection(
              title: '3. Layanan Pihak Ketiga',
              content:
                  'Aplikasi ini menggunakan layanan dari pihak ketiga yang memiliki kebijakan privasinya masing-masing, yaitu:\n'
                  '• Google Play Services\n'
                  '• Firebase Authentication\n'
                  '• Google Cloud Firestore',
            ),
            _buildSection(
              title: '4. Penghapusan Data Pengguna',
              content:
                  'Anda memiliki hak penuh atas data Anda. Anda dapat menghapus akun secara mandiri melalui menu "Akun" -> "Hapus Akun". Proses ini akan:\n'
                  '• Menghapus data akun Anda dari database kami.\n'
                  '• Memutuskan koneksi aplikasi dari akun Google Anda.\n'
                  '• Menghapus riwayat data alat yang terkait dengan akun Anda secara permanen.',
            ),
            _buildSection(
              title: '5. Keamanan',
              content:
                  'Kami menghargai kepercayaan Anda. Oleh karena itu, kami menggunakan Firebase yang memenuhi standar keamanan industri untuk melindungi informasi kredensial Anda. Namun, ingatlah bahwa tidak ada metode transmisi internet yang 100% aman dan andal.',
            ),

            SizedBox(height: 30.h),
            Center(
              child: Text(
                'Dengan menggunakan aplikasi ini, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan kebijakan ini.',
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // Widget helper biar kode gak berantakan
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppFonts.mdSemiBold),
          SizedBox(height: 8.h),
          Text(
            content,
            style: AppFonts.mdRegular.copyWith(height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
