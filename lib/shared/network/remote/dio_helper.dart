

import 'package:dio/dio.dart';

class dioHelper{
  static late Dio dio;

  static init(){
    print('in');
    dio = Dio(
      BaseOptions(baseUrl:'http://localhost:8000/api',receiveDataWhenStatusError: true )
    );
  }

  static Future<Response> getData(
    {
      required String url,

    }
  )async{
    return await dio.get(
      url,
    );
    
  }
}