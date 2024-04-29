import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/main%20Categories.dart';
import 'package:delivery/modules/marketPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    CarouselController controller = CarouselController();
    var categories=DeliveryCubit.get(context).catego;
    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: const Row(
              children: [
                Text('عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.brown),),
                Icon(Icons.location_on_sharp)
              ],
            ),
          ),
        )],
      ),
      body: SafeArea(
          child: (DeliveryCubit.get(context).offersData != null &&DeliveryCubit.get(context).catego!=null) ?Directionality(
           textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: ListView(
              children: [
                search(),
                slider(false,controller,context),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'What would you like to order?':'بدك تطلب ايش ؟',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                  ),),
                ),
                const SizedBox(height: 5,),
                GridView.count(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 1/0.75,
                  crossAxisSpacing: 0.2,
                  mainAxisSpacing: 0.2,
                  crossAxisCount: 3,children: List.generate(DeliveryCubit.get(context).catego!.data!.data.length,
                        (index)=> categories!=null? category( DeliveryCubit.get(context).catego!.data!.data[index],index,context):Skeleton(height: 300.0,width: double.infinity,),), ),
                 Padding(
                  padding:  const EdgeInsets.only(left: 10.0,right: 10),
                  child: Text(dropdownvalue=='English Language'?'Selections':'مختارات',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                  ),),
                ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(DeliveryCubit.get(context).offersData!.data!.banners.length, (index) => Container(
              margin: const EdgeInsets.all(8),
                height: 316,
              child: bigCard(dropdownvalue=='English Language'?'B-Laban':'بلبن',true,true,context),
                )),),
        ),
              ],
            ),
          ):Directionality(
            textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      search(),
                      Skeleton(height: 180.0,width: double.infinity,),
                       Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Text(dropdownvalue=='English Language'?'What would you like to order?':'بدك تطلب ايش ؟',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                        ),),
                      ),
                      GridView.count(
                        shrinkWrap: true, childAspectRatio: 1/1, crossAxisSpacing: 0, mainAxisSpacing: 0.2,
                        crossAxisCount: 3,children: List.generate(5,
                            (index)=> Column(
                              children: [
                                Skeleton(height: 60.0,),
                                Skeleton(height: 15.0,),
                              ],
                            ),), ),
                       Padding(
                        padding:  const EdgeInsets.only(left: 10.0,right: 10),
                        child: Text(dropdownvalue=='English Language'?'Selections':'مختارات',style:  TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.bold,fontSize: 20,
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
              ],
            ),
          )
      ),
    );
  },
);
  }
}

Widget category(modul,index,context){return InkWell(
  onTap: (){if(index==3){
    navigate(context, Market());
  }else{
    navigate(context, MainCategories());
  }
},
  child: Column(
    children: [CachedNetworkImage(
      height: 60,fit: BoxFit.cover,
      width: 100,
      imageUrl:'${modul.image}',
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (context,url) => const Center(child: CircularProgressIndicator()),),
      Text('${modul.name}',maxLines: 1,textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),)
    ],),
);}