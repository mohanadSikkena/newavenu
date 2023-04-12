import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/models/customer/customer_states.dart';
import 'package:newavenue/shared/components/loading_dialog.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

import '../../shared/styles/styles.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(CustomerInitialState());
  static CustomerCubit get(context) => BlocProvider.of(context);

  sendCustomerProperty({required BuildContext context , required String name, required String phone}) async {
    CancelToken token = CancelToken();
    loadingDialog(context: context).whenComplete(() {
      token.cancel();
    });
    await DioHelper.setData(url: '/customer/add-customer-property', query: {
      'name':name,
      'phone':phone
    }, cancelToken: token)
        .then((value) {
      if(Navigator.canPop(context)){
        Navigator.pop(context);
      } 

      if(value.data=="added successfully"){
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  margin: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    "Request Sent Successfully We Will Contact You Soon.",
                    style: f15TextBlackRegular,
                  )),
            );
          }).then((value) {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          });
      }
      
    }).
    onError((error, stackTrace) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  margin: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    "Request Failed Please Try Again.",
                    style: f15TextBlackRegular,
                  )),
            );
          });
    });
  
  }
}
