import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/search%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componants/componants.dart';
import 'Provider page.dart';

class MainCategories extends StatelessWidget {
  var categoryName;
  MainCategories({super.key,required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(listener: (context, state) {
      // TODO: implement listener
    },
      builder: (context, state) {
        final scaffoldKey = GlobalKey<ScaffoldState>();
        var newOffers=DeliveryCubit.get(context).offersData;
        var view=DeliveryCubit.get(context).changeViewNew;
        var providers=DeliveryCubit.get(context).categoryProvideData;
        return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(actions: [actionAppbar(context)]),
      body: SafeArea(child: (newOffers != null&&providers!=null&&state is !CategoryProviderLoading)?Directionality(
            textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: ListView(children: [
              search(double.infinity,dropdownvalue=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){navigate(context, SearchPage());}),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(newOffers.data!.banners.length, (index) => Container(
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
                  Text('$categoryName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
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
              if(providers.providers!.length==0)
                Padding(
                    padding: EdgeInsets.only(top: 170),
                    child: Center(child: Text(dropdownvalue=='English Language'?"This option doesn't work in your location":'هذه الخدمه غير متوفرة فى موقعك',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: providers.providers!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index)=>Container(
                    child: view?bigCard(providers.providers![index].providerName,providers.providers![index].description, true, false,
                        (){
                      values=[];
                      DeliveryCubit.get(context).getProviderFoodData(providers.providers![index].id);navigate(context, ProviderPage(providetDescription:providers.providers![index].description ,providetName: '${providers.providers![index].providerName}',providetCover: providers.providers![index].providerCover,providetimage: providers.providers![index].providerImage,));},
                        providers.providers![index].providerImage,providers.providers![index].providerCover,context):smallCard(providers.providers![index].providerName,providers.providers![index].providerImage,providers.providers![index].description,
                        (){
                          values=[];
                          DeliveryCubit.get(context).getProviderFoodData(providers.providers![index].id);navigate(context, ProviderPage(providetDescription:providers.providers![index].description ,providetName: '${providers.providers![index].providerName}',providetCover: providers.providers![index].providerCover,providetimage: providers.providers![index].providerImage,));},context))),
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
                        child: Text('${categoryName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
              Skeleton(height: 50.0,width:70.0 ),
              Skeleton(height: 50.0,width:65.0 ),
              Skeleton(height: 50.0,width:65.0 ),
              Skeleton(height: 50.0,width:65.0 ),
              if(MediaQuery.of(context).size.width>=410)
                Skeleton(height: 50.0,width:70.0 ),
                        ],
                      ),
                      SizedBox(height: 500,child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(physics:const NeverScrollableScrollPhysics(),itemCount:3,itemBuilder:(context,index)=> Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Skeleton(height: 75.0,width:75.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Skeleton(width: 80.0,height: 12.0),
                          Skeleton(width: 130.0,height: 12.0),
                          Skeleton(width: 200.0,height: 12.0),
                        ],)
                      ],
                    ),
                    seperate(),
                    Skeleton(width: 270.0,height: 10.0),
                  ],
                ),
              )))),
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
