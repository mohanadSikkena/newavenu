import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:newavenue/models/drawer/menu_item.dart';
import 'package:newavenue/models/drawer/contact_us.dart';
import 'package:newavenue/modules/home/home_page.dart';

import '../models/drawer/drawer_menu_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _drawerController = ZoomDrawerController();
  MenuItem currentItem=MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
          controller:_drawerController,
          mainScreenTapClose: true,

          androidCloseOnBackTap: true,
          dragOffset: 200.w,
          mainScreen: getScreen(),
          menuScreen: Builder(
            builder: (context) {
              return DrawerMenuScreen(
                currentItem:currentItem,
                onSelectedItem:(item){
                  setState(()=>currentItem=item);
                  ZoomDrawer.of(context)!.close();
              }

              );
            }
          ),
          showShadow: true,


        );
  }
  Widget getScreen(){
    switch (currentItem){
      case MenuItems.home :return const HomePage();
      case MenuItems.contactUs:return ContactUsScreen();
      default: return ContactUsScreen();
    }
  }
}
