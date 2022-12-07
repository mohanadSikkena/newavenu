

import 'package:dio/dio.dart';

class dioHelper{
  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(baseUrl:'http://192.168.1.7:81/api',receiveDataWhenStatusError: true )
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

    static Future<Response> setData({
    required String url,
    required dynamic query, 
  }) async{
    return await dio.post(
      
      url, 
      data: query,
      
      options: Options(
      
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,  
        )
      );
  }
}