import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/shared/styles/colors.dart';

import '../shared/styles/styles.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, states) {
          return Scaffold(
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        top: BorderSide(color: gray_2, width: 1))),
                child: BottomNavigationBar(
                  
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeIndex(index);
                  },
                  items: cubit.items,
                  elevation: 0.0,
                  iconSize: 28,
                  unselectedItemColor: gray_2,
                  selectedItemColor: primaryColor,
                  selectedLabelStyle: f10TextPrimaryRegular,
                  unselectedLabelStyle: f10TextGrayRegular_1,
                  showUnselectedLabels: true,
                )),
            body: cubit.screens[cubit.currentIndex],
          );
        },
        listener: (context, states) {});
  }
}
