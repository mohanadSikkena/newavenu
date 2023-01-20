import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/app/app_cubit.dart';
import 'package:newavenue/models/app/app_states.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/constant.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, states) {
          return Scaffold(
            backgroundColor: black,
            body: Stack(children: [
              PageView.builder(
                  controller: cubit.pageController,
                  itemCount: 3,
                  onPageChanged: (i) {
                    cubit.changeOnboardingScreen(i);
                  },
                  itemBuilder: (context, i) {
                    return OnboardingContent(
                        
                        screenDetails: Constant.onBoardingScreens,
                        currentScreen: i);
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 30,
                      left: 16,
                      right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedSmoothIndicator(
                          effect: ScrollingDotsEffect(
                              offset: 1,
                              dotHeight: 7,
                              dotWidth: 7,
                              dotColor: gray_3,
                              activeDotScale: 1.5,
                              activeDotColor: white),
                          activeIndex: cubit.currentOnboardingScreen,
                          count: 3),
                      customButton(
                        text: cubit.currentOnboardingScreen < 2 ? 'Next' : 'Get Started',
                        height: 50,
                        width: 150,
                        function: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_){
                          //   return widget.currentScreen<2?
                          //    OnboardingScreen(currentScreen: widget.currentScreen+1,):
                          //    const BottomNavBar();
                          // }));
                          
                            cubit.nextOnBoardingScreen(context);
                          
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          );
        },
        listener: (context, states) {});
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.screenDetails,
    required this.currentScreen,
  }) : super(key: key);

  final List<Map<String, dynamic>> screenDetails;
  final int currentScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Expanded(
          flex: 7,
          child: Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("${screenDetails[currentScreen]['img']}"),
                    fit: BoxFit.fill)),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            color: black,
            margin: const EdgeInsets.only(
                left: 16,
                right: 16),
           
            child: Stack(children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text('${screenDetails[currentScreen]["title"]}',
                      style: f40DisplayWhiteBold),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    '${screenDetails[currentScreen]["details"]}',
                    style: f17TextWhiteRegular,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
