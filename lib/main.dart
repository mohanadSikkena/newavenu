import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/search/search_cubit.dart';
import 'package:newavenue/modules/onboarding/onboarding.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

// ignore: unused_import
class Test{
  String name;
  Test({
    required this.name
  });
}


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  // await CacheHelper.sharedPreferences.clear();
  bool firstTime=await CacheHelper.getData(key: "id")==null;
  runApp( MyApp(firstTime:firstTime) ,);
}

class MyApp extends StatelessWidget {
  final  bool firstTime;
  const MyApp({Key? key , required this.firstTime}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context)=>PropertiesCubit()..index()..mostViews()..getAds()), 
          BlocProvider(create: (context) => SearchCubit()), 
          ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, states) {

              return MaterialApp(
                title: "Newavenue",
                // home: OnBoardingScreen(),
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
