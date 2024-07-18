import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'orderDetails.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
      body: SafeArea(child: topMenu.isNotEmpty?
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
                alignment: dropdownvalue=='English Language'?Alignment.bottomLeft:Alignment.bottomRight,
                child: Text(dropdownvalue=='English Language'? 'My order':'طلباتى',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),)),
            Expanded(child:ListView.builder(
                itemCount: topMenu.length,
                itemBuilder: (context,index)=>InkWell(
                    onTap: (){navigate(context, OrderDetails());},
                    child: orderCard('https://play-lh.googleusercontent.com/QziaUvJ3RXas5WbNrT1pIkeVaVLi9lfmqPxVUukBx0zuY5lPv13dVKyKEBYTKI-OCX5Y', dropdownvalue=='English Language'? 'KFC':'كنتاكى', '6:03,2024/7/4 '+'Am'))))
          ],),
      ):Center(
        child: Stack(
          children: [
          const Image(image: AssetImage('assets/bag.png'),height: 250,width: 200,),
          Positioned(
            left:dropdownvalue=='English Language'? 40:60,
              bottom: 30,
              child: Text(dropdownvalue=='English Language'?'No orders Founded':'لا توجد طلبات',style: TextStyle(fontWeight: FontWeight.w700),),)
        ],),
      )),
      ),
    );
  }
}
Widget orderCard(imageOrder,storeOrder,dateOrder)=>Card(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  image('$imageOrder', 40.0, 40.0, 40.0,BoxFit.cover),
                  SizedBox(width: 10,),
                  Expanded(child: Text('$storeOrder',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.green.shade400,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.only(left: 15,right: 15),child: Text('تم االتوصيل'),)
          ],),
        SizedBox(height: 5,),
        Row(
          children: [
            Text('$dateOrder'),
          ],
        )
      ],
    ),
  ),
);