import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/login/cubit/states.dart';
import 'package:tik_laen_taswaq2/modules/splash_screen.dart';
import 'package:tik_laen_taswaq2/shared/bloc_observer.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/cubit/cubit.dart';
import 'package:tik_laen_taswaq2/shared/cubit/states.dart';
import 'package:tik_laen_taswaq2/shared/network/local/cache_helper.dart';
import 'package:tik_laen_taswaq2/shared/network/remote/dio_helper.dart';
import 'package:wakelock/wakelock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'layout/cubit/cubit.dart';
import 'modules/billing/bill_screen.dart';
import 'layout/bottom_home_screen.dart';
import 'modules/goAddress_screen.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/welcome/welcome_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
late AndroidNotificationChannel? channel;

late FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = BottomHomeScreen();
    else
      widget = LoginScreen();
  } else {
    widget = SplashScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,

    ));
    Wakelock.enable();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getTodayOrder()
            ..getBalance()..getProfile(),
        ),
        BlocProvider<ShopLoginCubit>(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget,

              //  home: LoginScreen(),
              // home: WelcomeScreen(),
            ),
          );
        },
      ),
    );
  }
}