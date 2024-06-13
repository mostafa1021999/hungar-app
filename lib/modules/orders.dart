import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(child: Center(
      child: Stack(
        children: [
        const Image(image: AssetImage('assets/bag.png'),height: 250,width: 200,),
        Positioned(
          left:dropdownvalue=='English Language'? 40:60,
            bottom: 30,
            child: Text(dropdownvalue=='English Language'?'No orders Founded':'لا توجد طلبات',style: TextStyle(fontWeight: FontWeight.w700),),)
      ],),
    )),
    );
  }
}
