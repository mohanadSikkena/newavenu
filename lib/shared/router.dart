

import 'package:flutter/material.dart';



class CustomRouter{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static animatedNavigateTo({required Widget screen}){
    navigatorKey.currentState!.push(PageRouteBuilder(
        pageBuilder: (context,animation,secondaryAnimation)=>screen,
        transitionsBuilder:(context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0,0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),

    );

  }

  static pop(){
    navigatorKey.currentState!.canPop()?navigatorKey.currentState!.pop():null;
  }

  static normalPush({required Widget screen}){
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) {
      return screen;
    }));
  }


}