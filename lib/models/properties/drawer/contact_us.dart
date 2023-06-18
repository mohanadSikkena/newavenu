import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newavenue/models/customer/customer_cubit.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/network/remote/launcher_helper.dart';
import 'package:newavenue/shared/styles/colors.dart';


// ignore: must_be_immutable
class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> mainKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: const Icon(Icons.menu),
        ),),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: mainKey,
        child: ListView(
          children: [
             SizedBox(
              height: 40.h,
            ),

                Image(
                  height: 130.h,
                    image: AssetImage(Theme.of(context).colorScheme.background == black?'images/white_logo_crop.png':'images/black_logo_crop.png')
                ),
             SizedBox(
              height: 20.h,
            ),
            Card(
              elevation: 20,
              color: Theme.of(context).colorScheme.background,
              shadowColor: Theme.of(context).colorScheme.background == black
                  ? white
                  : black,
              surfaceTintColor: Theme.of(context).colorScheme.background,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Container(
                      height: 45.h,
                        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                        child: customTextField(
                            controller: nameController, text: 'Name')),
                    Container(
                      height: 45.h,
                        margin: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 16.h),
                        child: customTextField(
                            controller: phoneController, text: 'Phone')),
                    Container(

                      margin:  EdgeInsets.only(bottom: 16.0.h),
                      child: customButton(
                        height: 50.h,
                          text: 'Submit',
                          function: () async {
                            if (mainKey.currentState!.validate()) {
                              CustomerCubit.get(context).sendCustomerProperty(
                                context: context,
                                name: nameController.text,
                                phone: phoneController.text
                              );
                            }
                          }),
                    ),


                    Padding(
                      padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                          const Flexible(
                            child: Center(
                              child: Text(
                                'Or',
                                style: TextStyle(
                                  fontSize: 16,
                                  // Add any other text styles you need
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         IconButton(onPressed: (){
                           LauncherHelper.launchFacebook();
                         },
                             icon:  FaIcon(FontAwesomeIcons.facebook,color:const Color(0xff4267B2),size:38.h)),
                         IconButton(
                           padding: EdgeInsets.symmetric(horizontal: 20.w,),
                             onPressed: (){
                           LauncherHelper.launchInstagram();
                         },
                             icon:  ShaderMask(
                                 shaderCallback:  (Rect bounds) {
                                   return const  LinearGradient(
                                     begin: Alignment.topLeft,
                                     end: Alignment.bottomLeft,
                                     colors:
                                     [Color(0xff405DE6),
                                       Color(0xff5B51D8),
                                       Color(0xff833AB4),
                                       Color(0xffC13584),
                                       Color(0xffE1306C),
                                       Color(0xffFD1D1D),
                                       Color(0xffF56040),
                                       Color(0xffF77737)
                                       ,Color(0xffFCAF45),
                                       Color(0xffFFDC80)],
                                   ).createShader(bounds);
                                 },
                                 child: FaIcon(FontAwesomeIcons.instagram,size:38.h,color: white,))),
                         IconButton(onPressed: (){
                           LauncherHelper.launchWhatsapp(msg: "", context: context);

                         },
                             icon:  FaIcon(FontAwesomeIcons.whatsapp,color:const Color(0xff25D366),size:38.h)),

                        ],
                      ),
                    )






                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
