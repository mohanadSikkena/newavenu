import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/modules/onboarding/onboarding.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

// ignore: unused_import
import 'modules/auth_screens/login.dart';

void main() {
  dioHelper.init();
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
          BlocProvider(create: (context)=>PropertiesCubit()..index())
          ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, states) {
                  

              return const MaterialApp(
                // home: BottomNavBar()
                home: OnBoardingScreen(),
                // home: LogIn(),
              );
            },
            listener: (context, states) {
              
            }));
  }
}
