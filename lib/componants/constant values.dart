import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';

bool? isdark=Save.getdata(key: 'isdark');
String? balances=Save.getdata(key: 'balance');
PageController pageController = PageController(
  initialPage: 3,
);
dynamic token='';
String dropdownvalue=Save.getdata(key: 'lang');
ThemeData lightMode=ThemeData(
    fontFamily: dropdownvalue=='English Language'? 'fonten':'fontTop',
    primarySwatch: mainColor,
    primaryColor:mainColor
);
ThemeData darkMode=ThemeData(
  fontFamily: dropdownvalue=='English Language'? 'fonten':'fontTop',
  primaryColor: Colors.grey,
  brightness: Brightness.dark,
  hintColor: Colors.white,
  dividerColor: Colors.black12,
  appBarTheme: const AppBarTheme(
    color: Colors.black54,
  ),);