
import 'package:flutter/material.dart';

class Dimentions{
  static late double height;
  static late double width;
  static init(context){
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
  }
}