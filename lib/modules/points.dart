import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componants/componants.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 150,
              child: Card(
                child: Column(children: [
                  Row(children: [
                    Image(image: AssetImage('assets/giftbox.png'),height: 50,width: 50,),
                    SizedBox(width: 20,),
                    Text('0 ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                    Text(dropdownvalue=='English Language'?'Points':' نقطة',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ],),
                  Column(children: [
                    Text(dropdownvalue=='English Language'?'Collect 1000 points and get a 10 riyal discount':'أجمع 1000 نقطة و احصل على خصم 10 ريال',style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30),
                      child: seperate(),
                    ),
                  ],),
                ],),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 500,
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(dropdownvalue=='English Language'?'How work?':' كيف تعمل؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                      howPoints(dropdownvalue=='English Language'?'Order and collect points':'اطلب واجمع نقاط!','assets/bag.png',dropdownvalue=='English Language'?'for completed and paid order, you will receive 1 point for every 1 SAR you spend in order.':'مع كل طلب مكتمل ومدفوع ستحصل على 1 نقطة مقابل كل 1 ريال تنفقه على طلبك.'),
                      seperate(),
                      howPoints(dropdownvalue=='English Language'?'Discover the Shops and Restaurants':'اكتشف المتاجر و المطاعم','assets/store.png',dropdownvalue=='English Language'?'For every 1,000 points or 2,000 points you earn, you can get a 10 SAR or 20 SAR discount on your order from the selected restaurants and stores in your area.':'لكل 1000 نقطة أو 2000 نقطة تحصل عليها يمكنك الحصول على خصم 10 ريال أو 20 ريال على طلبك من المطاعم والمتاجر المختارة فى منطقتك.'),
                      seperate(),
                      howPoints(dropdownvalue=='English Language'?'Redeem your points':'استبدل نقاطق','assets/gift.png',dropdownvalue=='English Language'?'Replace your points with discounts through the checkout page when placing the order.':'استبدل نقاطق بخصومات من خلال صفحة الدفع عند تقديم الطلب.'),
                    ],),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
Widget howPoints(text,image,description)=>Expanded(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Image(image: AssetImage(image),height: 90,width: 80,),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          Flexible(child: Text(description,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),maxLines: 5,overflow: TextOverflow.ellipsis,))
        ],),
    )],),
);
