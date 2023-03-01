

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/user/user_states.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit() : super(UserInitialState());

  static UserCubit get(context)=>BlocProvider.of(context);

  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late bool customerRequestSent;
  
  addRequest({required BuildContext context})async{ 

    Map<String,dynamic>data={
      'name':nameController.text, 
      'phone':phoneController.text
    };

    FormData formData=FormData.fromMap(data);
    await DioHelper.setData(url: '/customer/add-customer-property', 
    query: formData).then((value)async {
      if(value.data=="added successfully"){
        customerRequestSent=await CacheHelper.putBool(key: 'customer_request_sent', value: true);
        emit(SendingSuccessState());
      }else{
        emit(SendingFailState());
        ScaffoldMessenger.of(context).showSnackBar(
          
          const SnackBar(content: Text('Send Request Failed'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          )
        );
      }
    }).onError((error, stackTrace) {
      emit(SendingFailState());
      ScaffoldMessenger.of(context).showSnackBar(
        
        const SnackBar(content: Text('Send Request Failed'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        )
      );
    });
    
    

  }
  

}