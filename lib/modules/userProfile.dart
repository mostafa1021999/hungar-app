import 'package:delivery/Cubite/app_dark_light_cubit.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/home.dart';
import 'package:delivery/modules/profile/edit%20data.dart';
import 'package:delivery/modules/profile/setting.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile/support.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    if(token==''){
      Save.savedata(key: 'token', value: '').then((value){
        });}
  },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Directionality(
            textDirection:dropdownvalue=='English Language'? TextDirection.rtl:TextDirection.ltr,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.person,
                    text: dropdownvalue=='English Language'?'Edit information':'حدث بياناتك',
                    hasNavigation: true,
                    onTap: (){
                      DeliveryCubit.get(context).getNewUser(context);
                      navigate(context, EditInformation());},
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.add_card_outlined,
                    text: 'Add Payment',
                    hasNavigation: false,
                  ),
                  ProfileListItem(
                    icon: Icons.help_outline,
                    text: dropdownvalue=='English Language'?'Help & Support':'الدعم و المساعدة',
                    hasNavigation: true,
                    onTap: (){navigate(context, Support());},
                  ),
                  ProfileListItem(
                    icon: Icons.settings,
                    text: dropdownvalue=='English Language'?'Settings':'الاعدادات',
                    hasNavigation: true,
                      onTap: (){navigate(context, Setting());}
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.person_add_alt_1,
                    text: dropdownvalue=='English Language'?'Invite a Friend':'ادعو اصدقائك',
                    hasNavigation: false,
                  ),
                  if(token!=''&&token!=null)
                  ProfileListItem(
                    icon: Icons.login,
                    text: dropdownvalue=='English Language'?'Logout':'تسجيل الخروج',
                    hasNavigation: false,
                    onTap: (){
                      token='';
                      balances=null;
                      Save.remove(key: 'token');
                      Save.remove(key: 'balance');
                      DeliveryCubit.get(context).current=3;
                      navigateAndFinish(context,const Home());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  var onTap;

   ProfileListItem({super.key,
    required this.icon,
    required this.text,
    required this.hasNavigation,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ).copyWith(
          bottom: 25,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isdark??false ?Colors.black12:floatActionColor,
        ),
        child: Directionality(
          textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                size: 20,
              ),
              SizedBox(width: 15),
              Text(
                this.text,
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
              ),
              Spacer(),
              if (this.hasNavigation)
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}