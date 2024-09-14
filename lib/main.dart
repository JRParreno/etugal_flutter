import 'dart:async';
import 'dart:convert';

import 'package:etugal_flutter/core/blocs/bloc_providers.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/core/provider/custom_notification.dart';
import 'package:etugal_flutter/core/theme/theme.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:etugal_flutter/dependency_injection_config.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initDependencies();

  runApp(
    MultiBlocProvider(
      providers: BlocProviders.blocs(di.serviceLocator),
      child: const MyApp(),
    ),
  );
}

Future<void> firebaseNotificationHandler(RemoteMessage? message) async {
  if (message != null) {
    CustomNotification.show(message);
  }
}

final router = routerConfig();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnectedToInternet = true;
  StreamSubscription? _internetConnectionStreamSubscription;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    checkIsUserLoggedIn();
    initFirebaseMessaging();
    // Future.delayed(const Duration(seconds: 2), () {
    //   FlutterNativeSplash.remove();
    // });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> initFirebaseMessaging() async {
    await Firebase.initializeApp();
    await CustomNotification.initialize();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   return;
    // });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message == null) return;
      CustomNotification.onSelectNotification(jsonEncode(message.data));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      CustomNotification.onSelectNotification(jsonEncode(message.data));
      // TODO handling notifications
    });

    FirebaseMessaging.onMessage.listen(firebaseNotificationHandler);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeMode,
        routerConfig: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }

  void checkIsUserLoggedIn() {
    // This will handle to get profile if user is logged in
    final sharedPreferencesNotifier =
        GetIt.instance<SharedPreferencesNotifier>();
    final bool isLoggedIn = sharedPreferencesNotifier.getValue(
        SharedPreferencesKeys.isLoggedIn, false);

    if (isLoggedIn) {
      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    }
  }

  void checkInternetConnection() {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() => isConnectedToInternet = true);
          break;
        case InternetStatus.disconnected:
          setState(() => isConnectedToInternet = false);
          break;
        default:
          setState(() => isConnectedToInternet = false);
      }

      if (!isConnectedToInternet) {
        const snackBar = SnackBar(
          content: Text("You are disconnected to the internet."),
        );

        scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
      }
    });
  }
}
