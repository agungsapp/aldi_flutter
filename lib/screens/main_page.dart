import 'package:flutter/material.dart';
import 'package:notifikasi/constants/colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.loginGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menambahkan gambar
              // Pastikan Anda sudah menambahkan gambar di folder 'assets'
              // dan sudah mendeklarasikannya di pubspec.yaml
              // Image.asset('assets/logo.png', height: 150),
              const SizedBox(height: 30),
              const Text(
                "Selamat Datang di Aplikasi Notifikasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Temukan informasi penting dengan mudah",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              // Menambahkan tombol
              ElevatedButton(
                onPressed: () {
                  // Logika untuk navigasi ke halaman lain
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Mulai Sekarang',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
