

import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static const String _url='http://192.168.1.5:81/';
  static  String get url=>_url;

  static init(){
    dio = Dio(
      
      BaseOptions(baseUrl:_url+'api',receiveDataWhenStatusError: true , )
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