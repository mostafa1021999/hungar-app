import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/restaurant%20page.dart';
import 'package:delivery/modules/search%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componants/componants.dart';

class MainCategories extends StatelessWidget {
  const MainCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(listener: (context, state) {
      // TODO: implement listener
    },
      builder: (context, state) {
        final scaffoldKey = GlobalKey<ScaffoldState>();
        var newOffers=DeliveryCubit.get(context).offersData;
        var view=DeliveryCubit.get(context).changeViewNew;
        return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(actions: [actionAppbar(context)]),
      body: SafeArea(child: (newOffers != null)?Directionality(
            textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: ListView(children: [
              search(double.infinity,dropdownvalue=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){navigate(context, SearchPage());}),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(newOffers!.data!.banners.length, (index) => Container(
                  padding: EdgeInsets.all(10),
                  width: 120, height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      imageUrl: '${newOffers.data!.banners[index].image}',
                      width: double.infinity, fit: BoxFit.cover,),
                  ),
                )),),),
              Padding(
                padding: const EdgeInsets.only(right:15.0,left: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dropdownvalue=='English Language'?'Restaurants':'المطاعم',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      children: [
                        viewNew(Icons.laptop_mac_rounded,view?mainColor:floatActionColor, view? floatActionColor:Colors.black,context),
                        viewNew(Icons.dehaze_rounded,view?floatActionColor:mainColor,view? Colors.black:floatActionColor ,context,),
                      ],
                    ),
                  )
                ],),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) => changeItems()
                  ),),),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index)=>Container(
                    child: view?bigCard(dropdownvalue=='English Language'?'B-Laban':"بلبن", true, false,
                        (){navigate(context, Restaurant());},context):smallCard(dropdownvalue=='English Language'?'B-Laban':"بلبن",(){navigate(context, Restaurant());},context))),
              )
            ],)):Directionality(
        textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
        child: ListView(children: [
                      search(double.infinity,dropdownvalue=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){navigate(context, SearchPage());}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
              Skeleton(height: 80.0,width:80.0 ),
              Skeleton(height: 80.0,width:80.0 ),
              Skeleton(height: 80.0,width:80.0 ),
              if(MediaQuery.of(context).size.width>=410)
                Skeleton(height: 80.0,width:80.0 ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0,left: 15),
                        child: Text(dropdownvalue=='English Language'?'Restaurants':'المطاعم',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
              Skeleton(height: 50.0,width:80.0 ),
              Skeleton(height: 50.0,width:80.0 ),
              Skeleton(height: 50.0,width:80.0 ),
              if(MediaQuery.of(context).size.width>=410)
                Skeleton(height: 50.0,width:80.0 ),
                        ],
                      ),
                      SizedBox(height: 500,child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(physics:const NeverScrollableScrollPhysics(),itemCount:3,itemBuilder:(context,index)=> Skeleton(height: 110.0,width:MediaQuery.sizeOf(context).width/1.2 )))),
                    ],),
            ))
    );},);
  }
}
Widget viewNew(icon,view,viewIcon,context)=>InkWell(
  onTap:(){DeliveryCubit.get(context).changeView();},
  child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color:view,),
      padding: EdgeInsets.all(4),
      child: Icon(icon,color:viewIcon,)),
);
