import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

import 'models/customer/customer_cubit.dart';
   
   
   
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ignore: unused_import
class Test{
  String name;
  Test({
    required this.name
  });
}


void main() async{


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    
  );
  DioHelper.init();
  await CacheHelper.init();
  bool firstTime=await CacheHelper.getData(key: "id")==null;
  runApp( MyApp(firstTime:firstTime) ,);
}

class MyApp extends StatelessWidget {
  final  bool firstTime;
  const MyApp({Key? key , required this.firstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context)=>CustomerCubit()),
          BlocProvider(create: (context)=>PropertiesCubit()..index()..mostViews()), 
          BlocProvider(create: (context) => SearchCubit()), 
          BlocProvider(create: (context) => CategoriesCubit()), 
          BlocProvider(create: (context) => LocationCubit()), 
          BlocProvider(create: (context) => PrimaryCubit()), 
          BlocProvider(create: (context) => AdsCubit()..getAds()), 
          ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, states){
              HelperClass.initDynamicLinks(context: context);

              return MaterialApp(
                
                theme: ThemeData(
                  
                  useMaterial3: true,
                  iconTheme: IconThemeData(color: black),
                  scaffoldBackgroundColor: white, 
                  colorScheme: ColorScheme.light(
                    background: white, 

                  ),
                  appBarTheme: AppBarTheme(color: white),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: white
                  ),
                  textTheme: TextTheme(
                      
                    
                    labelMedium: f15TextBlackRegular,
                    labelLarge: f15TextBlackSemibold,


                    headlineLarge: f17TextBlackSemibold, 
                    
                    displaySmall: f20TextBlackSemibold, 
                    displayMedium: f24DisplayBlackBold, 

                    displayLarge:f34DisplayBlackBold ,
                    
                  
                  )
                ),
                
              
                darkTheme:ThemeData(
                
                  useMaterial3: true,
                  
                  appBarTheme: AppBarTheme(color: black),

                  scaffoldBackgroundColor: black,
                  colorScheme: ColorScheme.dark(
                    
                    background: black
                  ),
                  iconTheme: IconThemeData(color: white),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: black
                  ),

                  textTheme: TextTheme(

                    
                    
                    labelMedium: f15TextWhiteRegular,
                    labelLarge: f15TextWhiteSemibold,


                    headlineLarge: f17TextWhiteSemibold, 
                    
                    displaySmall: f20TextWhiteSemibold, 
                    displayMedium: f24DisplayWhiteBold, 
                    
                    displayLarge:f34DisplayWhiteBold ,
                    
                    
                    
                  
                  )
                ),
                
                themeMode: ThemeMode.dark,
                
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: "Newavenue",
               
                home: 
                
                firstTime? 
                 const OnBoardingScreen()
                :const BottomNavBar(),
              );
            },
            listener: (context, states) {
              
            }));
  }
}
