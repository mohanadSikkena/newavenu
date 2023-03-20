

import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static const String _url='http://192.168.1.7:81/';
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
    CancelToken? cancelToken
    
  }) async{
    return await dio.post(
      
      url, 
      data: query,
      cancelToken: cancelToken ?? CancelToken(),
      options: Options(
      
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,  
        )
      );
  }
}