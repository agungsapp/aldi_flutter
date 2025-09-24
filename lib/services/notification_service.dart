import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Handler untuk notifikasi di background
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  // Singleton pattern
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  // Instance untuk Firebase Messaging dan Flutter Local Notifications
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  // Inisialisasi FCM dan notifikasi lokal
  Future<void> initialize() async {
    // Mengatur handler untuk pesan background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Meminta izin notifikasi
    await _requestPermission();

    // Mengatur handler untuk pesan
    await _setupMessageHandlers();

    // Mendapatkan dan mencetak FCM token
    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  // Meminta izin notifikasi (terutama untuk iOS)
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print('Status izin: ${settings.authorizationStatus}');
  }

  // Mengatur notifikasi lokal
  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    // Konfigurasi channel notifikasi untuk Android
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // ID channel
      'Notifikasi Penting', // Nama channel
      description: 'Channel untuk notifikasi penting',
      importance: Importance.high,
    );

    // Inisialisasi plugin notifikasi lokal
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Konfigurasi untuk iOS
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Inisialisasi pengaturan notifikasi lokal
    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  // Menampilkan notifikasi
  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'Notifikasi Penting',
            channelDescription: 'Channel untuk notifikasi penting',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }

  // Mengatur handler untuk pesan
  Future<void> _setupMessageHandlers() async {
    // Menangani notifikasi saat aplikasi di foreground
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // Menangani notifikasi saat aplikasi dibuka dari background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Menangani notifikasi saat aplikasi dibuka dari terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  // Menangani pesan background atau terminated
  void _handleBackgroundMessage(RemoteMessage message) {
    // Contoh: Navigasi ke layar tertentu berdasarkan data notifikasi
    if (message.data['type'] == 'chat') {
      // Tambahkan logika untuk navigasi ke layar chat
      print('Navigasi ke layar chat');
    }
  }
}
