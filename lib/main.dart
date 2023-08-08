import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/firebase_options.dart';
import 'package:application_ellocation/providers/language_provider.dart';
import 'package:application_ellocation/screens/auth/login_screen.dart';
import 'package:application_ellocation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel(
        "coding is life foreground", "coding is life foreground service",
        description: "This is channel des....", importance: Importance.high);

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initService();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(ChangeNotifierProvider<LanguageProvider>(
        create: (buildContext) {
          return LanguageProvider();
        },
        child: MyApp()));
  });
}

Future<void> initService() async {
  var service = FlutterBackgroundService();
  if (Platform.isIOS) {
    await flutterLocalPlugin.initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()));
  }
  await flutterLocalPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);
  await service.configure(
      iosConfiguration: IosConfiguration(
        onBackground: iosBackground,
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
          autoStart: true,
          notificationChannelId: "coding is life",
          initialNotificationTitle: "Coding is life",
          initialNotificationContent: "Awsome Content",
          foregroundServiceNotificationId: 90));
  service.startService();
}

@pragma("vm:enry-point")
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  service.on("setAsForeground").listen((event) {
    print("foreground ==============");
  });
  service.on("setAsBackground").listen((event) {
    print("background ==============");
  });
  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 2), (timer) {
    flutterLocalPlugin.show(
        90,
        "Cool Service",
        "Awsome ${DateTime.now()}",
        NotificationDetails(
            android: AndroidNotificationDetails(
                "coding is life", "coding is life service",
                ongoing: true)));
  });
}

@pragma("vm:enry-point")
Future<bool> iosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application Ellocation',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'MyArabicFont',
              fontWeight: FontWeight.normal,
              fontSize: 19),
          backgroundColor: Color(0xff81a969),
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(langProvider.currentLanguage),
      home: APIs.auth.currentUser != null ? HomeScreen() : LoginScreen(),
    );
  }
}
