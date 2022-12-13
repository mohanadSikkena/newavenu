import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';
import '../../modules/home_page.dart';
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
     HomePage(),
    const SavedScreen(),
  ];
  int currentOnboardingScreen = 0;
  int currentIndex = 0;
  PageController pageController = PageController();

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Saved"),
    
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  changeOnboardingScreen(index) {
    currentOnboardingScreen = index;
    emit(ChangeOnBoardingScreen());
  }

  

  nextOnBoardingScreen(BuildContext context) async{

    if(currentOnboardingScreen < 2){
      pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }else{

      await DioHelper.getData(url: '/customer/create-new-customer').then((value){
        
        CacheHelper.putInt(key: 'id', value: value.data["id"]);
      }).onError((error, stackTrace){
        
      });

      Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const BottomNavBar();
          }));

    
    }
    emit(NextOnBoardingScreen());
    

  }
}
