import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/user/user_cubit.dart';
import 'package:newavenue/models/user/user_states.dart';
import 'package:newavenue/shared/components/custom_button.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';

class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> mainKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserCubit cubit=UserCubit.get(context);

    return BlocConsumer<UserCubit,UserStates>(
      builder:(context,state){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Support', style: Theme.of(context).textTheme.titleLarge ,),
            elevation: 0.0,
            
            leading: IconButton(onPressed: (){
              cubit.nameController.clear();
              cubit.phoneController.clear();
              Navigator.pop(context);
            }, icon: Icon(
              Icons.arrow_back_ios, 
              color: Theme.of(context).iconTheme.color,
            )), 
          ),
          body: 
              Form(
                key: mainKey,
                
                   child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                     Image.asset(
                      Theme.of(context).backgroundColor==black?
                      'images/white_logo.png':
                      'images/black_logo.png'
                      , height: 200,
                      ), 

                    customTextField(
                      height: 60,
                      marginLeft: 16,
                      marginRight: 16,
                      controller: cubit.nameController, node: FocusNode(), onTapFunction: (){}, onSubmit: (){}, text: 'Your Name'),
                    const SizedBox(height: 20,),
                    customTextField(
                      height: 60,
                      marginLeft: 16,
                      marginRight: 16,controller: cubit.phoneController, node: FocusNode(), onTapFunction: (){}, onSubmit: (){}, text: 'Your Phone'),
                  Container(
                  margin:const  EdgeInsets.only(top: 80 ,left: 16, right: 16),
                  child: customButton(
                        text: 'Submit', function: (){
                          if(mainKey.currentState!.validate()){
                            showDialog(context: context, builder: (context){
                              return Dialog(
                                child: Text('Your Request Sent Successfully And We Will Call You Soon'),
                              );
                            });
                          }
                      
                      }),
                ),
                   ]),
                  
                 ) , 
                
                
                
           
        );
      } , listener: (context,state){});
  }
}