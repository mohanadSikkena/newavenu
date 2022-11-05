

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';



class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:AssetImage('images/login/login.jpg'),fit: BoxFit.fill )
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(

              width: double.infinity,
            )),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(left: 16,right: 16),
          
                
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    Text("Welcome user",style: f28DisplayBlackBold,),
                    
                    Text("Sign up to join",style: f17TextgrayRegular_3,),
                    const SizedBox(height: 41,),
                    customTextField(
                      marginLeft:16 ,
                      marginRight: 16,
                      blackText: true,
                      search: false,
                      controller: TextEditingController(), 
                      node: FocusNode(), 
                      onTapFunction: (){}, onSubmit: 
                      (){}  ,
                      text: "Name"),
                    customTextField(
                      marginLeft:16 ,
                      marginRight: 16,
                      blackText: false,
                      search: false,
                      controller: TextEditingController(), 
                      node: FocusNode(), 
                      onTapFunction: (){}, onSubmit: 
                      (){}  ,
                      text: "Email"),
                    customTextField(
                      marginLeft: 16,
                      marginRight: 16,
                        obSecure: true,
                        search: false,
                        controller: TextEditingController(), 
                        node: FocusNode(), 
                        onTapFunction: (){}, 
                        onSubmit:(){} , 
                        text: "Password"),    
                    
                    const SizedBox(height: 25,),
                    Row(  
                      children: [
                        const SizedBox(width: 16,),
                        Expanded(
                          child: customButton(
                            
                            text: "Sign up", 
                            function: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                return const BottomNavBar();
                              })
                              );
                            }),
                        ),
                        const SizedBox(width: 16,)
                      ],
                    ) ,
                      Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top: 20),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            text:TextSpan(
                              
                              

                                text:
                                    "By clicking Sign up, you will create an account and agree to ours ",
                                style: f13TextGrayRegular_1,
                                children: [
                                  TextSpan(
                                      text: 'Terms of Service ',
                                      style: f13TextPrimaryRegular,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                  TextSpan(
                                      text: 'and ',
                                      style: f13TextGrayRegular_1),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: f13TextPrimaryRegular,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {})
                                ]),
                          ),
                        )
      
                  ]
                  ),
              ),
            ),
            Expanded(child: Row(
              
              children: [
                Expanded(child: Container()),
                Text('Have an account?',style:f17TextgrayRegular_2 ,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(" Sign in",style: f17TextWhiteSemibold,)),
                  Expanded(child: Container())
              ],
            ) )
        
        ],
      
      
        ),
      )
      
      ,
      
    );
  }
}



