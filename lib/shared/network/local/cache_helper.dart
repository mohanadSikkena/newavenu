

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }


  static Future putInt({
    required String key, 
    required int value
  })async{
    return await sharedPreferences.setInt(key,value );
  }
  static Future putData({
    required String key,
    required String value
  })async{
    return await sharedPreferences.setString(key,value );
  }

  static getData({
    required String key
  }){
      return  sharedPreferences.get(key);    

  }
}