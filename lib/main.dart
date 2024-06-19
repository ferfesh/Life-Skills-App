import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'services/booking_service.dart';
import 'services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initialize(); // Initialize notification service
  runApp(MyApp(navigatorKey: navigatorKey));

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  MyApp({required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BookingService()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Life Skills',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        home: Scaffold(
          appBar: AppBar(
            title: Text('Life Skills App'),
          ),
          body: const Center(
            child: Text('Welcome to Life Skills App!'),
          ),
        ),
        /* home: Consumer<AuthService>(
          builder: (context, authService, _) {
            if (authService.user != null) {
              return HomeScreen();
            }
            return LoginScreen();
          },
        ), */
      ),
    );
  }
}
