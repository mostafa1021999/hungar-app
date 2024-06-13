import 'package:delivery/Cubite/app_dark_light_cubit.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      'English Language',
      'اللغه العربيه',
    ];
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {},
  builder: (context, state) {
    isdark ??= false;

    return Scaffold(
      appBar: AppBar(
        title: Text(dropdownvalue=='English Language'?'Settings':'الاعدادات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: dropdownvalue!='English Language'?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(dropdownvalue=='English Language'?'Choose language':'اختار اللغه',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(false,'English',"assets/english.png",dropdownvalue=='English Language'?Icons.check:null,dropdownvalue=='English Language'?mainColor.shade400: Colors.transparent,'English Language',dropdownvalue=='English Language'?mainColor.shade400:isdark??false?floatActionColor:borderColor,context),
                languageAndThem(false,'عربى',"assets/arabic.png",dropdownvalue!='English Language'?Icons.check:null,dropdownvalue!='English Language'?mainColor.shade400: Colors.transparent, 'اللغة العربيه',dropdownvalue!='English Language'?mainColor.shade400:isdark??false?floatActionColor:borderColor,context),
              ],
            ),
            SizedBox(height: 20,),
                  Text(dropdownvalue=='English Language'?'Dark them':'العرض المظلم',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(true,dropdownvalue=='English Language'?'Dark mode':'العرض المظلم',Icons.dark_mode,isdark??false?Icons.check:null,isdark??false?mainColor.shade400: Colors.transparent,dropdownvalue=='English Language'?'Dark mode':'العرض المظلم',isdark??false?mainColor.shade400:isdark??false?floatActionColor:borderColor,context),
                languageAndThem(true,dropdownvalue=='English Language'?'Light mode':'العرض المضئ',Icons.light_mode,!isdark!?Icons.check:null,!isdark!?mainColor.shade400: Colors.transparent,'English Language',!isdark!?mainColor.shade400:isdark??false?floatActionColor:borderColor,context),
              ],
            ),

          ],
        ),
      ),
    );
  },
);
  }
}
Widget languageAndThem(them,text,flag,icon,color,onTapLang,textBorderColor,context,)=>SizedBox(
  height: 150,
  width: 150,
  child: InkWell(
    onTap: them?(){AppDarkLightCubit.get(context).changeapppmode();
    isdark=!isdark!;
    Save.putdata(key: 'isdark', value: isdark??false);
    DeliveryCubit.get(context).increment();}
        :(){Save.savedata(key: 'lang', value:onTapLang ).then((value){
      DeliveryCubit.get(context).changeLanguage(onTapLang);
    });},
    child: Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: Align( alignment: Alignment.topRight,child: CircleAvatar(backgroundColor:color,radius:10,child: Icon(icon,size: 18,color: Colors.white,))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: 60,
            height: 50,
            decoration:  BoxDecoration(
              border: Border.all(color: textBorderColor,width: 1),
            ),
            child: them?Icon(flag,color: textBorderColor,):Image.asset(flag),
          ),
          Spacer(),
          Text(text,style: TextStyle(color: textBorderColor,fontWeight: FontWeight.w600),),
          SizedBox(height: 15,)
        ],
      ),
    ),
  ),
);