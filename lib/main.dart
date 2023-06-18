import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/firebase_options.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/models/ads/ads_cubit.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/models/categories/categories_cubit.dart';
import 'package:newavenue/models/locations/locations_cubit.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/search/search_cubit.dart';
import 'package:newavenue/modules/onboarding/onboarding.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';
import 'package:newavenue/shared/network/remote/dynamic_helper.dart';
import 'package:newavenue/shared/network/remote/notifications_helper.dart';
import 'package:newavenue/shared/router.dart';
import 'package:newavenue/shared/theme/dark.dart';
import 'package:newavenue/shared/theme/light.dart';

import 'models/customer/customer_cubit.dart';


// ignore: unused_import

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    log("Handling a background message: ${message.notification!.title}");
    log("Handling a background message: ${message.notification!.body}");
  }
}

void main() async {




  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await CacheHelper.init();
  await FirebaseNotifications.getFCM();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);


  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      FirebaseNotifications firebaseNotifications=FirebaseNotifications();
      firebaseNotifications.showMyNotification(message);
    }

  });
  DioHelper.init();
  bool firstTime = await CacheHelper.getData(key: "id") == null;
  if(firstTime){
    CacheHelper.putData(key: 'mode', value: ThemeMode.system.toString());
    FirebaseMessaging.instance.subscribeToTopic("all");
  }runApp(
    MyApp(firstTime: firstTime),
  );
}

class MyApp extends StatelessWidget {
  final bool firstTime;
  const MyApp({Key? key, required this.firstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(375,768),
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => AppCubit()),
                  BlocProvider(create: (context) => CustomerCubit()),
                  BlocProvider(
                      create: (context) => PropertiesCubit()
                        ..index()
                        ..mostViews()),
                  BlocProvider(create: (context) => SearchCubit()),
                  BlocProvider(create: (context) => CategoriesCubit()),
                  BlocProvider(create: (context) => LocationCubit()),
                  BlocProvider(create: (context) => PrimaryCubit()),
                  BlocProvider(create: (context) => AdsCubit()..getAds()),
                ],
                child: BlocConsumer<AppCubit, AppStates>(
                    builder: (context, states) {
                      HelperClass.initDynamicLinks(context: context);

                      return MaterialApp(
                        useInheritedMediaQuery: true,
                        theme: lightTheme,
                        darkTheme: darkTheme,
                        themeMode: AppCubit.get(context).currentMode,
                        navigatorKey: CustomRouter.navigatorKey,
                        debugShowCheckedModeBanner: false,
                        title: "Newavenue",
                        builder: (BuildContext context, Widget? child) {
                          final MediaQueryData data = MediaQuery.of(context);
                          return MediaQuery(
                              data: data.copyWith(textScaleFactor: 1),
                              child: child ?? const OnBoardingScreen());
                        },
                        home: firstTime
                            ? const OnBoardingScreen()
                            : const BottomNavBar(),
                      );
                    },
                    listener: (context, states) {})));
  }
}
