import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import 'colors.dart';
bool loginFromCart=false;

Widget actionAppbar(context)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: InkWell(
    onTap: (){
      showModalBottomSheet(context: context, builder: (BuildContext context){
        return Container(
          padding: EdgeInsets.all(10),
          height: 140,child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
              textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 25.0, color: Colors.red,),
                  Flexible(child: Text( DeliveryCubit.get(context).currentLocationName!=''?'${DeliveryCubit.get(context).currentLocationName}':dropdownvalue=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color:isdark??false? floatActionColor:brownColor),)),
                ],),
            ),
            Spacer(),
            bottom(dropdownvalue=='English Language'?'Change order location':'تغيير موقع الطلب', (){
                  navigate(context,
                      Maps(initialLocationName: '${DeliveryCubit.get(context).currentLocationName}',firstPosition: DeliveryCubit.get(context).position1??0,secondPosition:DeliveryCubit.get(context).position2??0 ,
                      ));})
          ],),);});
    },
    child: Container(
      width: MediaQuery.sizeOf(context).width/1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: Text(DeliveryCubit.get(context).currentLocationName!=''?'${DeliveryCubit.get(context).currentLocationName}':dropdownvalue=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color:isdark??false? floatActionColor:brownColor),)),
          const Icon(
            Icons.location_on,
            size: 25.0, color: Colors.red,),
        ],),
    ),
  ),
);

Widget buildTextField(
    IconData icon, String hintText, bool isPassword, type,{controller,validator}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Palette.iconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle:const TextStyle(fontSize: 14, color: Palette.textColor1),
      ),

    ),
  );
}
Widget date(text,selected){
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Palette.textColor1),
      borderRadius: BorderRadius.circular(35)
    ),
    child: Row(
      children: [
        Icon(
          Icons.date_range,
          color: Palette.iconColor,
        ),
        SizedBox(width: 15,),
        Text(text,style:TextStyle(fontSize: 14, ))
      ],
    ),
  );
}
navigate( context,screen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => screen));
}
void navigateAndFinish(context , Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget bottom(data,onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: mainColor.shade400,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Center(child:  Text(data  , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white))),
    ),
  );
}
Widget cartPaymentBottom(text,onTap,context)=>Container(
  color: isdark??false? Colors.black12:floatActionColor,
  width: double.infinity,
  padding: const EdgeInsets.only(bottom: 10.0,top: 10,left: 15,right: 15),
  child: InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: mainColor.shade400,borderRadius: BorderRadius.circular(10)),
      height: 50,
      width: MediaQuery.sizeOf(context).width/1.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(dropdownvalue=='English Language'? 'Sar':'ريال',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(width: 5,),
              Text('5',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            ],
          ),
          Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        ],),
    ),
  ),
);
Widget bigCard(name,load,mainPage,onTap,context)=>InkWell(
  onTap: onTap,
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment:dropdownvalue=='English Language'? MainAxisAlignment.end:MainAxisAlignment.start,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: mainPage?150.0:160,
            child:  Stack(
              children: [
                image('https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhVPeYv-tKVHszneiR3M1Je9bD65K-eoWKT2vOb8KyDEinI8H4spz4zzCrf6flGxCswS4jiVa5KwsML2731rxjydmQTwSSIcJ0b9lYiKOnEDLipZEbefhy1yH7puXTenvZnFUu_eIvQKQFeIyToLg1XSWMx4a8SsVLFYNcepwuyEQAqdkmDWUHKdi2P/s800/%D9%85%D9%86%D9%8A%D9%88-%D8%A8%D9%84%D8%A8%D9%86-%D8%A8%D8%A7%D9%84%D8%A7%D8%B3%D8%B9%D8%A7%D8%B1.jpg', 180.0, mainPage?MediaQuery.sizeOf(context).width/1.4:MediaQuery.sizeOf(context).width/1.11,15.0),
                Positioned(
                  top: 10, right: 10, height:50, width: 50,
                  child:image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg', 50.0, 50.0,15.0),),
                Positioned(
                  top: 10, left: 10, height:25,
                  child:mainPage?Container(
                    decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,color: Colors.amber,),Text("4.3 (750)",style: TextStyle(color: brownColor),),
                        ],
                      ),
                    ),
                  ):Container(
                    decoration: BoxDecoration(color:brownColor.shade50,borderRadius: BorderRadius.circular(5)),
                    child:  Padding(
                      padding:const EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.more_time_rounded,color: brownColor,),SizedBox(width: 5,),Text(dropdownvalue=='English Language'?"30 -40 Minutes | 0.5 KM":"40-30 دقيقة| 0.5 كم",style: TextStyle(color: brownColor),),
                        ],
                      ),
                    ),
                  ),),
                Positioned(
                    bottom: 0, right: 0, height:25,
                    child:Container(
                      decoration: BoxDecoration(color:mainPage?Colors.yellow.shade100:freeOrderColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),topLeft: Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                        child:mainPage? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stars_rounded,color: Colors.blue,),Text(dropdownvalue=='English Language'?'Best in 2023':"الافضل فى 2023",style: TextStyle(color: Colors.black),),
                          ],
                        ):Text(dropdownvalue=='English Language'?'Free delivery(spend 15 SAR)':"توصيل مجانى (عند الطلب ب 15 ريال)",style: TextStyle(color: Colors.white,fontSize: 12),),
                      ),
                    )),
                Positioned(
                    bottom: 0, left: 0, height:25,
                    child:Container(
                      decoration: BoxDecoration(color:mainPage?borderColor.shade200:floatActionColor,borderRadius:mainPage? BorderRadius.circular(5):BorderRadius.only(bottomRight: Radius.circular(5.0),topRight: Radius.circular(5.0))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0,right: 8),
                        child: mainPage ?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(dropdownvalue=='English Language'?'Advertisement':"اعلان",style: TextStyle(color: Colors.black),),
                          ],
                        ):Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star,color: Colors.amber,),Text("4.3 (750)",style: TextStyle(color: brownColor)),
                          ],
                        ),
                      ),
                    )),
              ],
            )
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8),
          child: Text('$name',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ),
         Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8),
          child: Text(dropdownvalue=='English Language'?'Milk add to sweets':"لبن زايدينه حلى",style: TextStyle(color:isdark??false? floatActionColor:borderColor,fontSize: 13),),
        ),
        if(mainPage)
        Container(
          decoration: BoxDecoration(color:brownColor.shade50,borderRadius: BorderRadius.circular(15)),
          child:  Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.more_time_rounded,color: brownColor,),SizedBox(width: 5,),Text(dropdownvalue=='English Language'?'30-40 Minutes':"30 -40 دقيقة",style: TextStyle(color: brownColor),),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6,),
        if(mainPage)Container(
          decoration: BoxDecoration(color:Colors.blue.shade50,borderRadius: BorderRadius.circular(15)),
          child:  Padding(
            padding:const EdgeInsets.only(left: 8.0,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_box_rounded,color: Colors.blue,),SizedBox(width: 5,),Text(dropdownvalue=='English Language'?'Free delivery(spend 15 SAR)':"توصيل مجانى (عند الطلب ب15 ريال)",style: TextStyle(color: Colors.blue),),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);
Widget smallCard(name,onTap,context)=>InkWell(
  onTap: onTap,
  child: Card(
    child: Column(
      children: [
        Row(
          children: [
            image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg', 75.0, 75.0,15.0),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8),
                    child: Text(
                      '$name', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                      style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8),
                    child: Text(
                      dropdownvalue=='English Language'?'Milk add to sweets':"لبن زايدينه حلى",
                      style: TextStyle(fontSize: 13,color:isdark??false? floatActionColor: borderColor), maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                        color:Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_box_rounded,color: Colors.blue,),
                          const SizedBox(width: 5,),
                          Text(
                            dropdownvalue=='English Language'?'Free delivery(spend 15 SAR)':"توصيل مجانى (عند الطلب ب15 ريال)",
                            style: TextStyle(color: Colors.blue,fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Container(
          width:double.infinity,
          height: 1.5,
          color:isdark??false? mainColor.shade400: borderColor,
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Icon(Icons.star,color: Colors.amber,),
            Text("4.3 (750)",style: TextStyle(color:isdark??false? floatActionColor: brownColor),),
            Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: CircleAvatar(radius:3,backgroundColor:isdark??false? mainColor.shade400: borderColor,),
            ),
            Icon(Icons.location_on_outlined,color:isdark??false? floatActionColor: brownColor,),
            Text(dropdownvalue=='English Language'?'0.5 KM':"0.5 كم",style: TextStyle(color:isdark??false? floatActionColor: brownColor),),
            Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: CircleAvatar(radius:3,backgroundColor:isdark??false? mainColor.shade400: borderColor,),
            ),
            Icon(Icons.more_time_rounded,color: isdark??false? floatActionColor:brownColor,),
            SizedBox(width: 5,),
            Text(dropdownvalue=='English Language'?'30 -40 Minutes':"30 -40 دقيقة",style: TextStyle(color:isdark??false? floatActionColor: brownColor),),
          ],
        ),
        SizedBox(height: 5,),
      ],
    ),),
);
Future bottomSheet(context,widget,{controller})=>showModalBottomSheet(
    transitionAnimationController: controller,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return widget;});
Widget search(width,data,onTap)=>Padding(
  padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
  child: InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: 50,decoration: const BoxDecoration(border: Border(bottom: BorderSide(color:mainColor,width: 1.5,
    )
    ),color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5,),
          Icon(Icons.search,size: 25,color: brownColor,),
          const SizedBox(width: 15,),
          Text(data,style: TextStyle(fontSize: 15,color: Colors.grey),),
        ],
      ),),
  ),
);
Widget searchData(dataSearch,controller)=>TextFormField(
  autofocus: true,
  validator: (value){
    if(value!.isEmpty){return 'Enter text to search';}
    return null;
  },
  onChanged: (String text){
    if(text.isNotEmpty)
      dataSearch;
  },
  controller: controller,
  decoration: const InputDecoration(label: Text('search'),
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.text,
);
Widget Skeleton({height,width})  {
    return Shimmer.fromColors(
      baseColor: borderColor[300]!,
      highlightColor: borderColor[100]!,
      child: Padding(
        padding: EdgeInsets.all(5),
            child: Container(
              height: height,
              width: width,
              color: Colors.white,
            ),
      ));}
Widget changeItems()=>Padding(
  padding: const EdgeInsets.all(5),
  child: InkWell(
    onTap: (){},
    child: Container(
      height: 50,decoration: BoxDecoration(border: Border.all(color:borderColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 3,), Icon(Icons.tune_outlined,color: brownColor,),
          SizedBox(width: 3,), Text("تصفيه",style: TextStyle(color: brownColor),),
          SizedBox(width: 3,), Icon(Icons.keyboard_arrow_down,color: brownColor,)
        ],
      ),),
  ),
);
Widget image(url,height,width,reduis)=>ClipRRect(
  borderRadius: BorderRadius.circular(reduis),
  child: CachedNetworkImage(
    placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) =>  Icon(Icons.error),
    imageUrl: '$url',
    height: height,
    width: width,
    fit: BoxFit.fill,),);
Widget slider(market,controller,context)=>CarouselSlider(
    carouselController: controller,
    items: DeliveryCubit.get(context).offersData!.data!.banners.map((e) => Padding(
      padding: const EdgeInsets.all(10.0),
      child:ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: CachedNetworkImage(
          placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: '${e.image}',
          width: double.infinity,
          fit: BoxFit.cover,),
      ),
    )).toList(),
    options: CarouselOptions(
      onPageChanged: (index, reason) {
        DeliveryCubit.get(context).changeAdds(index);
      },
      aspectRatio: 9.0 / 9.0,
      viewportFraction: 0.8,
      initialPage:DeliveryCubit.get(context).offersData!.data!.banners.length,height: 250,autoPlay: true,autoPlayInterval:const Duration(seconds: 10),
      autoPlayAnimationDuration: const Duration(seconds: 3),enableInfiniteScroll: true,
    ));
Widget dots(length,context)=>Directionality(
  textDirection: TextDirection.rtl,
  child: Center(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) => SizedBox(
          child: Container(
              margin: const EdgeInsets.all(8),
              width: 8,
              child:  Icon(Icons.circle_rounded,color:DeliveryCubit.get(context).advertising==index? mainColor: Colors.grey,size: 12,)),
        )),
      ),
    ),
  ),
);
Widget menuItems(onTap,canAdd,index1,index2,itemcount,context,onTheImage)
{
  return StatefulBuilder(
    builder:(context,setstate)=> Container(
      height: 135,
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(canAdd)  Text(
              "قابل للتخصيص",
              style: TextStyle(color: isdark??false? floatActionColor:borderColor,fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
            Stack(
              children: [
                image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg', 110.0, 100.0,15.0),
                Positioned(
                    bottom: 0,
                    child: onTheImage!=null? onTheImage:InkWell(
                        onTap:onTap,child: CircleAvatar(radius: 15,child: Icon(Icons.add,color: Colors.white,),backgroundColor: mainColor.shade400,)))
              ],
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8),
                child: Text(
                  '${bottomMenu[index1][index2]}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                  style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor.shade400),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left:8.0,right: 8),
                child: Text(
                  "رز بلبن بالمكسرات و النوتيلا و الاضافات",
                  style: TextStyle(color: isdark??false? floatActionColor:borderColor), maxLines: 2, overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'سعره حراريه', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                    style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor.shade300),
                  ),SizedBox(width: 5,),
                  Text(
                    '200', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                    style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor.shade300),
                  ), Icon(Icons.local_fire_department_rounded,color: isdark??false? floatActionColor:brownColor,),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8),
                    child: Text(
                      '18 ريال', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                      style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],),
    ),
  );}
Widget topBar(name,color,textColor)=>Container(
  padding: EdgeInsets.all(8),
  decoration: BoxDecoration(
    border:Border(
      bottom: BorderSide(
        color: color,
        width: 2.0, ),),
      ),
  child: Center(
    child: Text(
      '$name', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
      style:TextStyle(
          fontSize: 18,fontWeight: FontWeight.w600,color: textColor),
    ),
  ),);
final List<List<String>> bottomMenu = [
  ['رز بلبن بالمكسرات', 'رز بلبن بالمكسرات 2', 'رز بلبن بالمكسرات 3'],
  ['Item 2-1', 'Item 2-2'],
  ['Item 3-1', 'Item 3-2', 'Item 3-3', 'Item 3-4'],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5'],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5','Item 4-5','Item 4-5','Item 4-5'],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5','Item 4-5','Item 4-5','Item 4-5','Item 4-5','Item 4-5','Item 4-5',],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5'],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5'],
  ['Item 4-1', 'Item 4-2', 'Item 4-3', 'Item 4-4','Item 4-5'],
];
List<String> topMenu=['ارز بلبن','حلو خضراء','الحسو الجديد','قسم المشنكاح','جديد','جديد اوى','جديد اوى','جديد اوى','جديد اوى'];
int calculateTotalLength(List<List<String>> bottomMenu,index) {
  int totalLength = 0;
  for (var i = 0; i < index; i++) {
    totalLength += bottomMenu[i].length;
  }
  return totalLength;
}
Widget addOrRemoveOne(itemsNumber,context,add,remove,mainPage)=>Container(
  margin: mainPage?EdgeInsets.only(left: 20,bottom: 10):EdgeInsets.zero,
  padding: EdgeInsets.all(mainPage?10:5),
  width: mainPage? MediaQuery.sizeOf(context).width/3:100,
  height:mainPage? 50:30,
  decoration: BoxDecoration(
      color: mainColor.shade400,
      borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      InkWell(child: Icon(Icons.add,color: Colors.white,),onTap: add),
      Text(
        '$itemsNumber', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
        style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      InkWell(child:itemsNumber==1&&mainPage==false? Icon(Icons.restore_from_trash_outlined,color: Colors.white,):Icon(Icons.remove,color: Colors.white,),onTap: remove,),
    ],
  ),
);
Widget seperate() =>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: isdark??false ? floatActionColor:Colors.grey,
        width: 0.8,
      ),
    ),
    color: Colors.orangeAccent,
  )),
);

List<Map<dynamic, int>> values = [];
