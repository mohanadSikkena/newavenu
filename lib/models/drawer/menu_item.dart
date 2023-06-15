import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem{
  final String name;
  final IconData icon;
  const MenuItem(this.name,this.icon);
}

class MenuItems{
  static const MenuItem home=MenuItem("Home",FontAwesomeIcons.house );
  static const MenuItem contactUs=MenuItem("Contact Us", FontAwesomeIcons.phone);
  static const List<MenuItem> all=<MenuItem>[home,contactUs];
}