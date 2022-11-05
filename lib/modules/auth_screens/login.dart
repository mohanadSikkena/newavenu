

import 'package:flutter/material.dart';
import 'package:newavenue/layout/botton_navigation_bar.dart';
import 'package:newavenue/modules/auth_screens/signup.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';


class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: gray_3,
          image: const DecorationImage(
            image:AssetImage("images/login/login.jpg"), fit: BoxFit.fill )
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
                    Text("Welcome back",style: f28DisplayBlackBold,),
                    
                    Text("Sign in to continue",style: f17TextgrayRegular_3,),
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
                            
                            text: "Sign In", 
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
                      const SizedBox(height:25),
                      Text("Forgot password?",style: f17TextPrimaryRegular,)   ,
      
                  ]
                  ),
              ),
            ),
            Expanded(child: Row(
              
              children: [
                Expanded(child: Container()),
                Text('Don’t have an account?',style:f17TextgrayRegular_2 ,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return const SignUp();
                    }));
                  },
                  child: Text("Sign up",style: f17TextWhiteSemibold,)),
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