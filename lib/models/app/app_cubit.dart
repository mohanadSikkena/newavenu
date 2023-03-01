import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';
import '../../modules/home_page.dart';
import '../../modules/properties/saved_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  

  List<Widget> screens =  [
    const HomePage(),
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

      navigatorKey.currentState!.push( MaterialPageRoute(builder: (_) {
            return const BottomNavBar();
          }));

    
    }
    emit(NextOnBoardingScreen());
    

  }
}
