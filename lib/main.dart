import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:link_go/app/bottom_nav/nav.dart';
import 'package:link_go/providers/account_provider.dart';
import 'package:link_go/services/navigation/navigator_service.dart';
import 'package:link_go/services/navigation/router.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/locator.dart';
import 'package:link_go/utils/progress_bar_manager/dialog_manager.dart';
import 'package:link_go/utils/progress_bar_manager/dialog_service.dart';
import 'package:link_go/utils/storage_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'app/splashScreen/splashscreen.dart';

// NEW: Store initial notification globally
// RemoteMessage? _initialMessage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  StorageUtil.createSharedPref();
  setupLocator();
  //await dotenv.load();
  // Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: dotenv.env["FIREBASE_API_KEY"] ?? "",
  //     appId: dotenv.env["FIREBASE_APP_ID"] ?? "",
  //     messagingSenderId: dotenv.env["MESSAGING_SENDER_ID"] ?? "",
  //     projectId: dotenv.env["PROJECT_ID"] ?? "",
  //   ),
  // );

  // NEW: Get initial notification before runApp()
 // _initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // late FirebaseMessaging messaging;
  // late AndroidNotificationChannel channel;

  // void selectNotification(String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(builder: (context) => const BottomNav()),
  //   );
  // }

  // displayDialog(String title, String body) {
  //   return showTopSnackBar(
  //     Overlay.of(NavigatorService.navigationKey_.currentContext!),
  //     CustomSnackBar.info(
  //       backgroundColor: AppColors.primaryColor,
  //       message: "$title\n$body",
  //       textStyle: GoogleFonts.poppins(
  //         color: Colors.white,
  //         fontSize: 12.sp,
  //         fontWeight: FontWeight.w500,
  //       ),
  //       messagePadding: EdgeInsetsGeometry.symmetric(horizontal: 10.0),
  //     ),
  //   );
  // }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // void registerNotification() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('app_icon');
  //   final DarwinInitializationSettings initializationSettingsDarwin =
  //   DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //   );
  //
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsDarwin,
  //     macOS: initializationSettingsDarwin,
  //   );
  //
  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse:
  //         (NotificationResponse notificationResponse) {},
  //   );
  //
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //   await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {}
  //
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //     if (kDebugMode) {
  //       print("message received");
  //     }
  //     if (kDebugMode) {
  //       print(event.notification?.body);
  //     }
  //     displayDialog(
  //         '${event.notification?.title}', '${event.notification?.body}');
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  // }

  // Future<void> _messageHandler(RemoteMessage message) async {
  //   if (kDebugMode) {
  //     print('Handling a background message ${message.messageId}');
  //   }
  //   if (kDebugMode) {
  //     print('background message ${message.notification?.body}');
  //   }
  // }

  // void getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("FCM Token: $token");
  // }

  @override
  initState()  {
    if (!Platform.isIOS)  {
      // String? apnsToken =  await FirebaseMessaging.instance.getAPNSToken();
      // print("APNs token: $apnsToken");
      //
      // String? fcmToken = await FirebaseMessaging.instance.getToken();
      // print("FCM token: $fcmToken");

    } else {
      Firebase.initializeApp();
    }

    // registerNotification();
    // getToken();
    // FirebaseMessaging.onBackgroundMessage(_messageHandler);
    //
    // // NEW: Handle terminated notification
    // if (_initialMessage != null) {
    //   print("App opened from terminated state via notification");
    //   print("Title: ${_initialMessage!.notification?.title}");
    //   print("Body: ${_initialMessage!.notification?.body}");
    //   // Example navigation (customize as needed)
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (_) => const BottomNav()),
    //   );
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return StyledToast(
          locale: const Locale('en', 'US'),
          toastAnimation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.fade,
          toastPositions: StyledToastPosition.top,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 7),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastLinearToSlowEaseIn,
          dismissOtherOnShow: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              dialogTheme: const DialogThemeData(
                backgroundColor: Colors.white,
              ),
              bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Color(0xFFFFFF)),
              scaffoldBackgroundColor: Colors.grey.shade50, // AppColors.scaffoldBackgroundColor,

              bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white),
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  color: Color(0xFFFFFFFF),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xFFFFFFFF),
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                  )),
            ),
            builder: (context, child) => Navigator(
              key: locator<ProgressService>().progressNavigationKey,
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) {
                    return ProgressManager(
                      child: child!,
                    );
                  }),
            ),
            navigatorKey: locator<NavigatorService>().navigationKey,
            home: SplashScreen(),
            onGenerateRoute: generateRoute,
          ),
        );
      },
    );
  }
}
