import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:notifikasi/theme/app_theme.dart';
import 'package:notifikasi/screens/splash_screen.dart';
import 'package:notifikasi/screens/login_page.dart';
import 'package:notifikasi/screens/register_page.dart';
import 'package:notifikasi/screens/main_page.dart';
import 'package:notifikasi/routes/app_routes.dart';
import 'package:notifikasi/global_callbacks.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Setup OneSignal sebelum runApp
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize("eee77d3b-13ec-488a-9aac-09abf6794764");
//   // Minta izin notifikasi (true = paksa prompt)
//   await OneSignal.Notifications.requestPermission(true);
//   // Tambahkan listener untuk debug subscription
//   OneSignal.User.pushSubscription.addObserver((state) {
//     debugPrint(
//       "Push subscription state changed: ${state.jsonRepresentation()}",
//     );
//   });

//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("eee77d3b-13ec-488a-9aac-09abf6794764");
  await OneSignal.Notifications.requestPermission(true);

  // 🔑 Tambahkan listener notifikasi
  OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
    debugPrint(
      "Ada notifikasi masuk: ${event.notification.jsonRepresentation()}",
    );

    // ✅ Tidak perlu event.complete() kalau kamu cuma mau biarkan notifikasi tampil
    // event.preventDefault(); // <-- pakai ini hanya kalau mau sembunyikan notifikasi

    // 🔄 Panggil refresh MemoPage
    GlobalCallbacks.onNewMemo?.call();
  });

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
