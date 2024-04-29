import 'package:delivery/Cubite/app_dark_light_cubit.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      'English Language',
      'اللغه العربيه',
    ];
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Directionality(
            textDirection:dropdownvalue=='English Language'? TextDirection.rtl:TextDirection.ltr,
            child: ListView(
              children: [
                profile(),
            Directionality(
              textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isdark??false? Colors.black12:floatActionColor, border: Border.all(color: borderColor),),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  underline: Container(), // Add this line to remove the border
                  style: TextStyle(color:isdark??false?floatActionColor:Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'fontTop'),
                  dropdownColor:isdark??false? borderColor:floatActionColor,
                  icon:  Icon(Icons.keyboard_arrow_down,color:isdark??false? floatActionColor:Colors.brown,size: 25,),
                  isExpanded: true,
                  value :dropdownvalue ,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    Save.savedata(key: 'lang', value:newValue ).then((value){
                      dropdownvalue='$newValue';
                      DeliveryCubit.get(context).changeLanguage(newValue);
                    });
                    Save.savedata(key: 'lang', value:newValue ).then((value){
                    });
                  },
                ),
                      ),
              ),
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Switch(
            // This bool value toggles the switch.
            value: isdark??false,
            activeColor: mainColor.shade400,
            onChanged: (bool value) {
              isdark=value;
              AppDarkLightCubit.get(context).changeapppmode();
              DeliveryCubit.get(context).increment();
              }),
                  Text(dropdownvalue=='English Language'?'Dark Them':'العرض المظلم',
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'fontTop'),),
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
Widget profile()=>Padding(
  padding: const EdgeInsets.only(bottom: 15.0),
  child: Directionality(
    textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
    child:TextField(
      readOnly: true, // Set the readOnly property to true
      decoration: InputDecoration(
        labelStyle:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'fontTop'),
        labelText: dropdownvalue=='English Language'?'Phone number':"رقم الهاتف",
        contentPadding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: brownColor, width: 5.5),
        ),
      ),
      controller: TextEditingController(text: '0566310766',),
    ),
  ),
);
