import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('السلة',style: TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
            Text('طلباتى',style: TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(children: [
              image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg', 40.0, 40.0, 40.0),

            ],)
            ],
          ),
        ),
      ),
    );
  }
}
