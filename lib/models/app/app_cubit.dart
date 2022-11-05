import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/modules/auth_screens/login.dart';

import '../../modules/agent/account.dart';
import '../../modules/connections/connections.dart';
import '../../modules/home_page.dart';
import '../../modules/notifications/notifications_scree.dart';
import '../../modules/properties/saved_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> onBoardingScreens = [
    {
      "title": "Discover place near you",
      "details":
          "Find the best place you want by your location or neighborhood",
      "img":
          "images/onboarding/onboarding-1.jpg"
    },
    {
      "title": "Search for place easily",
      "details":
          "Decide where to sleep with family and friends to enjoy the beautiful day",
      "img":
          "images/onboarding/onboarding-2.jpg"
    },
    {
      "title": "Ready to move in beautiful place",
      "details":
          "A beautiful day with hot chocolate in a new place with loved ones",
      "img":
          "images/onboarding/onboarding-3.jpg"
    }
  ];

  List<Widget> screens =  [
    const HomePage(),
    const ConnectionsScreen(),
    const SavedScreen(),
    const NotificationsScreen(),
    const AccountScreen()
  ];
  int currentOnboardingScreen = 0;
  int currentIndex = 0;
  PageController pageController = PageController();

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
    BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_rounded), label: "Connections"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Saved"),
    BottomNavigationBarItem(
        icon: Icon(Icons.notifications), label: "Notifications"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  changeOnboardingScreen(index) {
    currentOnboardingScreen = index;
    emit(ChangeOnBoardingScreen());
  }

  nextOnBoardingScreen(BuildContext context) {
    currentOnboardingScreen < 2
        ? pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease)
        : Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const LogIn();
          }));

    emit(NextOnBoardingScreen());
  }
}
