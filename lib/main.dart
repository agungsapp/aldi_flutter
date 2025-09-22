import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notifikasi/theme/app_theme.dart';
import 'package:notifikasi/screens/splash_screen.dart';
import 'package:notifikasi/screens/login_page.dart';
import 'package:notifikasi/screens/register_page.dart';
import 'package:notifikasi/screens/main_page.dart';
import 'package:notifikasi/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "masukkan-apiKey-anda", // Contoh: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      authDomain:
          "masukkan-authDomain-anda", // Contoh: "your-project-id.firebaseapp.com"
      projectId: "masukkan-projectId-anda", // Contoh: "your-project-id"
      storageBucket:
          "masukkan-storageBucket-anda", // Contoh: "your-project-id.appspot.com"
      messagingSenderId:
          "masukkan-messagingSenderId-anda", // Contoh: "1234567890"
      appId:
          "masukkan-appId-anda", // Contoh: "1:1234567890:web:xxxxxxxxxxxxxxxxxxxxxxxx"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skripsi App',
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
