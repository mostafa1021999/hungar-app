import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';

bool? isdark=Save.getdata(key: 'isdark');
dynamic token='';
String dropdownvalue=Save.getdata(key: 'lang');
final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  dividerColor: Colors.white54,
);