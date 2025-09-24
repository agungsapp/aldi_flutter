import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notifikasi/theme/app_theme.dart';
import 'package:notifikasi/screens/splash_screen.dart';
import 'package:notifikasi/screens/login_page.dart';
import 'package:notifikasi/screens/register_page.dart';
import 'package:notifikasi/screens/main_page.dart';
import 'package:notifikasi/routes/app_routes.dart';
// import 'package:notifikasi/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "masukkan-apiKey-anda", // Ganti dengan apiKey dari Firebase Console
      authDomain: "masukkan-authDomain-anda", // Ganti dengan authDomain
      projectId: "masukkan-projectId-anda", // Ganti dengan projectId
      storageBucket:
          "masukkan-storageBucket-anda", // Ganti dengan storageBucket
      messagingSenderId:
          "masukkan-messagingSenderId-anda", // Ganti dengan messagingSenderId
      appId: "masukkan-appId-anda", // Ganti dengan appId
    ),
  );
  // await NotificationService.instance
  //     .initialize(); // Inisialisasi NotificationService
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahaha App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.main: (context) => const MainPage(),
      },
    );
  }
}
