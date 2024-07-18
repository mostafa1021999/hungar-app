import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/main%20Categories.dart';
import 'package:delivery/modules/maps.dart';
import 'package:delivery/modules/marketPage.dart';
import 'package:delivery/modules/search%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Provider page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    double opecity=0;
    double moneyOpecity=1;
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    CarouselController controller = CarouselController();
    var providers=DeliveryCubit.get(context).providerData;
    return StatefulBuilder(
      builder:(context,setState)=> NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final double offset = _scrollController.offset;
            setState(() {
               if (offset > 70 ) {
                  opecity=1;
                  moneyOpecity=0;
              } else {
                opecity = 0;
                moneyOpecity=1;
               }
            });
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Disable the automatic back button
            title: Stack(
              children: [
                if(token!=null&&token!='')
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200), // Duration of the animation
                    opacity: moneyOpecity,
                    child: Row(
                      children: [
                        Text('ر.س',style: TextStyle(fontSize: 16),),
                        SizedBox(width: 5,),
                        Text(balances!=null?'$balances':'0.0',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),),
                      ],
                    )),
                AnimatedOpacity(
                    duration: const Duration(milliseconds: 200), // Duration of the animation
                    opacity: opecity,
                    child:InkWell(onTap:(){if(opecity==1)navigate(context, SearchPage());},child: const Icon(Icons.search,size: 25,))),
              ],
            ),
            actions: [actionAppbar(context)],
          ),
          body: (DeliveryCubit.get(context).offersData != null&&state is !GetUserSuccess &&DeliveryCubit.get(context).categoryData!=null) ?Directionality(
           textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: ListView(
              controller: _scrollController,
              children: [
                search(double.infinity,dropdownvalue=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){navigate(context, SearchPage());}),
                slider(false,controller,context),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'What would you like to order?':'ودك تطلب ايش اليوم ؟',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                  ),),
                ),
                const SizedBox(height: 5,),
                GridView.count(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 1/0.75,
                  crossAxisSpacing: 0.2,
                  mainAxisSpacing: 0.2,
                  crossAxisCount: 4,children: List.generate(DeliveryCubit.get(context).categoryData!.length,
                      (index)=> DeliveryCubit.get(context).categoryData!=null? category( DeliveryCubit.get(context).categoryData![index],index,context):Skeleton(height: 300.0,width: double.infinity,),),),
                 Padding(
                  padding:  const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'Selections':'مختارات',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                  ),),
                ),
                      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(providers!.data!.length, (index) => Container(
              margin: const EdgeInsets.all(5),
              child: bigCard(providers.data![index].providerName,providers.data![index].description??'',true,true,(){
                DeliveryCubit.get(context).expandedHeight = 345.0;DeliveryCubit.get(context).imageHeight = 200.0;
                DeliveryCubit.get(context).containerHeight=180.0;DeliveryCubit.get(context).currentIndex=0;DeliveryCubit.get(context).opecity=1;
                DeliveryCubit.get(context).containerPadding=100;DeliveryCubit.get(context).rowItems=150;
                DeliveryCubit.get(context).getProviderFoodData(providers.data![index].id);
                values=[];price=0;
                Navigator.push(
                context,
                PageTransition(
                  child: ProviderPage(providetDescription:providers.data![index].description ,providetName: '${providers.data![index].providerName}',providetCover: providers.data![index].providerCover,providetimage: providers.data![index].providerImage,),
                  type: PageTransitionType.downToUp,
                ),
              );},providers.data![index].providerImage,providers.data![index].providerCover,context),
                )),),
                      ),
              ],
            ),
          ):Directionality(
            textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: ListView(
              controller: _scrollController,
              children: [
                search(double.infinity,dropdownvalue=='English Language'?'Search for a restaurant or stores':'ابحث عن المطاعم او المتاجر',(){navigate(context, SearchPage());}),
                Skeleton(height: 180.0,width: double.infinity,),
                 Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'What would you like to order?':'ودك تطلب ايش اليوم ؟',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                  ),),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true, childAspectRatio: 1/1, crossAxisSpacing: 0, mainAxisSpacing: 0.2,
                  crossAxisCount: 4,children: List.generate(8,
                      (index)=> Column(
                        children: [
                          Skeleton(height: 60.0,),
                          Skeleton(height: 15.0,),
                        ],
                      ),), ),
                 Padding(
                  padding:  const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'Selections':'مختارات',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                  ),),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) => Container(
                      width: MediaQuery.sizeOf(context).width/1.3, height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(height: 150.0), Skeleton(height: 10.0,width: 60.0), Skeleton(height: 10.0,width: 150.0), Skeleton(height: 10.0,width: 200.0),
                        ],
                      ),
                    )),),
                ),
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
enum PageTransitionType { downToUp }

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;

  PageTransition({
    required this.child,
    required this.type,
    RouteSettings? settings,
  }) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return child;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      switch (type) {
        case PageTransitionType.downToUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        default:
          return child;
      }
    },
    transitionDuration: Duration(milliseconds: 200),
    settings: settings,
  );
}

Widget category(modul,index,context){return InkWell(
  onTap: (){
    DeliveryCubit.get(context).categoryProvider(modul.id);
    navigate(context, MainCategories(categoryName:'${modul.name}'));
  },
  child: Column(
    children: [CachedNetworkImage(
      height: 60,fit: BoxFit.cover,
      width: 80,
      imageUrl:'${modul.image}',
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (context,url) => const Center(child: CircularProgressIndicator()),),
      Flexible(
        child: Text('${modul.name}',maxLines: 1,textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),),
      )
    ],),
);}