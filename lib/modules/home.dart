import 'package:blured_navigation_bar_x/blured_navigation_bar_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/login.dart';
import 'package:delivery/modules/main%20page.dart';
import 'package:delivery/modules/orders.dart';
import 'package:delivery/modules/points.dart';
import 'package:delivery/modules/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubite/delivery_cubit.dart';
import 'otp number.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        bottomNavigationBar:BluredNavigationBarX(
            browColor: mainColor,
          backgroundColor: isdark??false? Colors.black12:Colors.white,
          selectedItemColor: mainColor,
          unselectedItemColor:isdark??false?Colors.white:Colors.grey,
        currentIndex: DeliveryCubit.get(context).current,
        items:dropdownvalue=='English Language'? DeliveryCubit.get(context).bottomEn :DeliveryCubit.get(context).bottomAr,
          onPressed: (index) {   DeliveryCubit.get(context).changeNavigator(index);
          pageController.jumpToPage(index);},),
        body:PageView(
          controller: pageController,
          onPageChanged: (index) {
            DeliveryCubit.get(context).changeNavigator(index);
          },
          children: <Widget>
          [
            const UserProfile(),
            token=='' ||token==null?Login():const Points(),
            token==''||token==null?Login():const Orders(),
            MainPage(),
          ],
        )
    );
  },
);
  }
}
