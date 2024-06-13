import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Stack(
          children: [
            const Image(image: AssetImage('assets/gift.png'),height: 250,width: 200,),
            Positioned(
              left:dropdownvalue=='English Language'? 40:60,
              bottom: 25,
              child: Text(dropdownvalue=='English Language'?'No points Founded':'لا توجد نقاط',style: TextStyle(fontWeight: FontWeight.w700),),)
          ],),
      )),
    );
  }
}
