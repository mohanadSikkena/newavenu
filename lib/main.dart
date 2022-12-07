import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
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
  dioHelper.init();
  await CacheHelper.init();
  // await CacheHelper.sharedPreferences.clear();
  print(CacheHelper.getData(key: "id"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context)=>PropertiesCubit()..index()..mostViews()..getAds())
          ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, states) {

              return MaterialApp(
                home: CacheHelper.getData(key: "id")==null? OnBoardingScreen():BottomNavBar(),
              );
            },
            listener: (context, states) {
              
            }));
  }
}
