import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/cart.dart';
import 'package:delivery/modules/main%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
class Restaurant extends StatefulWidget {
  const Restaurant({super.key});

  @override
  State<Restaurant> createState() => _Restaurant();
}

class _Restaurant extends State<Restaurant>with SingleTickerProviderStateMixin{
  late AnimationController controller;
  TextEditingController searchController = TextEditingController();
  bool showSearch=false;
  @override
  void initState(){
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children:[ Expanded(
                child: Container(
                  color:isdark??false? Colors.grey:Colors.white,
                  child: CustomScrollView(
                    controller: DeliveryCubit.get(context).scrollControllerColumn,
                    slivers: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500), // Set your desired duration
                      child: SliverAppBar(
                        automaticallyImplyLeading: false,
                        expandedHeight: DeliveryCubit.get(context).expandedHeight,
                          bottom: PreferredSize(preferredSize: Size.fromHeight(240),child: Card(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: double.infinity,
                                color: isdark??false? Colors.black87:floatActionColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                  child:
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.search,size: 25,color: isdark??false ? floatActionColor:brownColor,),onPressed: (){setState(() {
                                        showSearch=true;
                                      });},),
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: ScrollablePositionedList.builder(
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: topMenu.length,
                                            itemBuilder: (context, index) => InkWell(
                                              onTap: (){DeliveryCubit.get(context).scrollToIndex(index);},
                                              child: topBar(topMenu[index],index == DeliveryCubit.get(context).currentIndex ? mainColor.shade400 : isdark??false? Colors.black87:floatActionColor,
                                                  index == DeliveryCubit.get(context).currentIndex ? mainColor.shade300:isdark??false? floatActionColor:brownColor),
                                            ),
                                            itemScrollController: DeliveryCubit.get(context).itemScrollController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),),
                          pinned: true,
                          floating: true, // Set to true
                          snap: true,
                        flexibleSpace: SafeArea(
                          child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300), // Duration of the animation
                                  height: DeliveryCubit.get(context).imageHeight,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/logoApp.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0,left: 20),
                                  child: InkWell(
                                    onTap: (){Navigator.pop(context);},
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: borderColor.shade300,
                                      child: Icon(
                                        color: Colors.black,
                                        size: 22,
                                          Icons.close,
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedPadding(
                                    duration: Duration(milliseconds: 400), // Duration of the animation
                                    padding: EdgeInsets.only(top: DeliveryCubit.get(context).containerHeight==180? DeliveryCubit.get(context).containerPadding+100:DeliveryCubit.get(context).containerPadding+40),
                                    child: Container(width: double.infinity,color:isdark??false? Colors.black:floatActionColor,height:DeliveryCubit.get(context).containerHeight,)),
                                AnimatedPadding(
                                  duration: Duration(milliseconds: 200), // Duration of the animation
                                  padding: EdgeInsets.only(top: DeliveryCubit.get(context).containerPadding),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200), // Duration of the animation
                                    padding: EdgeInsets.all(10),
                                    height:DeliveryCubit.get(context).containerHeight,
                                    width: MediaQuery.of(context).size.width-38,
                                    margin: EdgeInsets.only(left: 20,right: 20),
                                    decoration: BoxDecoration(
                                        color: isdark??false? Colors.blueGrey.shade500:Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black87.withOpacity(0.3),
                                              blurRadius: 15, spreadRadius: 1),]),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              image('https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg', 40.0, 40.0, 40.0),
                                              Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                child: Text('بلبن',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              ),
                                            ],),
                                          AnimatedOpacity(
                                              duration: Duration(milliseconds: 300), // Duration of the animation
                                              opacity: DeliveryCubit.get(context).opecity,
                                              child: Text("لبن زايدينه حلى",style: TextStyle(color: isdark??false? floatActionColor:borderColor.shade500,fontWeight: FontWeight.w500,fontSize: 16),)),
                                          Container(height: 40,), // Add the Spacer widget
                                          AnimatedOpacity(
                                            duration: Duration(milliseconds: 500), // Duration of the animation
                                            opacity: DeliveryCubit.get(context).opecity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(children: [Text("مدة التوصيل",style: TextStyle(fontSize: 13,color: isdark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                                                  Text('20 - 30 دقيقة',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),),
                                                ],),
                                                Column(children: [Text("رسوم التوصيل",style: TextStyle(fontSize: 13,color: isdark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                                                  Text('0 - 15 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:isdark??false? floatActionColor:brownColor),),
                                                ],),Column(children: [Text("الحد الادنى للطلب",style: TextStyle(fontSize: 13,color: isdark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
                                                  Text('20 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),),
                                                ],),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),]),
                        ),
                      ),
                    ),
                      DecoratedSliver(
                        decoration: BoxDecoration(
                          color: isdark??false? Colors.black87:floatActionColor,
                        ),
                        sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ListTile(  horizontalTitleGap: 0,
                                title:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text('${topMenu[index]}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isdark??false ? Colors.white:brownColor),)),
                              subtitle: Column(
                                children: [
                                  SizedBox(height:bottomMenu[index].length*155,child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,indexNew) =>InkWell(
                                      onTap: (){bottomSheet(context, _CustomBottomSheet(onTap: '${bottomMenu[index][indexNew]}',canAdd:index%2==0?true:false,),controller: controller);},
                                      child: menuItems(index%2==0?(){
                                        bottomSheet(context, _CustomBottomSheet(onTap: '${bottomMenu[index][indexNew]}',canAdd:index%2==0?true:false,),controller: controller);}
                                          :(){DeliveryCubit.get(context).addValue('${bottomMenu[index][indexNew]}',1);},index%2==0?true : false,index,indexNew,1,context,
                                          DeliveryCubit.get(context).isNameInList(bottomMenu[index][indexNew])? addOrRemoveOne(DeliveryCubit.get(context).getValueByName(bottomMenu[index][indexNew]), context, index%2==0?(){
                                            bottomSheet(context, _CustomBottomSheet(onTap: '${bottomMenu[index][indexNew]}', canAdd:index%2==0?true:false,),controller: controller,);}:(){DeliveryCubit.get(context).addValue('${bottomMenu[index][indexNew]}', 1);}, (){DeliveryCubit.get(context).minusValue('${bottomMenu[index][indexNew]}', 1);},false):null),
                                    )
                                    ,itemCount: bottomMenu[index].length, separatorBuilder: (BuildContext context, int index) =>seperate(),)),
                                  if(DeliveryCubit.get(context).currentIndex!=topMenu.length-1)
                                  seperate()
                                ],
                              ) ,
                            );
                          }, childCount: topMenu.length,
                        ), ),
                    ),
                  ],
                        ),
                ),
              ),
                 if(values.isNotEmpty)
                   cartPaymentBottom(dropdownvalue=='English Language'? 'Show cart':'عرض السله', (){navigate(context, Cart());}, context)
              ]
            ),
            if(showSearch)
              Container(height: double.infinity,width: double.infinity,color: Colors.black54,child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){setState(() {
                        showSearch=false;
                      });}, icon: Icon(Icons.arrow_back_outlined,color: floatActionColor,)),
                      Container(
                        width: MediaQuery.sizeOf(context).width/1.35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFF5F5F5),),
                        child: TextField(
                          autofocus: true,
                          controller: searchController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter amount to stake',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                searchController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],),),
          ],
        ),
      ));
  },
);
  }

}


class _CustomBottomSheet extends StatefulWidget {
   var onTap;
   bool canAdd;
  @override
  _CustomBottomSheet({required this.onTap,required this.canAdd});
  _CustomBottomSheetState createState() => _CustomBottomSheetState( onTap:onTap,canAdd: canAdd);
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  Color containerColor = Colors.white;
  ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;
  int itemsNumber=1;
  late double imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4;
   var onTap;
  bool canAdd;
  List<List<bool>> checklist = List.generate(
    bottomMenu.length,
        (index) => List.filled(bottomMenu[index].length, false),
  );
  _CustomBottomSheetState({required this.onTap,required this.canAdd});
  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] = value;
    });
  }
  @override
  void initState() {
    super.initState();
    _bottomSheetController.addListener(bottomSheetScroll);
  }
  void bottomSheetScroll(){
    setState(() {
      if (_bottomSheetController.offset >20&&_bottomSheetController.offset<50 ) {
        imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4-_bottomSheetController.offset*2.5;
      }else if(_bottomSheetController.offset <=20){
        imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4;
      }
    });
  }
  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }
  void addValue(String name, int value) {
    setState(() {
      bool valueExists = false;
      for (var map in values) {
        if (map.containsKey(name)) {
          map[name] = (map[name]! + 1);
          valueExists = true;
          break;
        }
      }
      if (!valueExists) {
        values.add({name: value});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height-50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300), // Duration of the animation
              height: imageBottomSheetHeight,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10) ),
                  image: DecorationImage(
                      image: NetworkImage("https://images.deliveryhero.io/image/hungerstation/restaurant/android_cover_photo/99995897a8808d19a4cafb0be3677cec.jpg"),
                      fit:BoxFit.cover
                  )),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
              ),),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(
                'رز بلبن', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:isdark??false? floatActionColor: brownColor),
              ),
            ),
             Padding(
              padding:const EdgeInsets.only(left:15.0,right: 15),
              child: Text(
                "رز بلبن بالمكسرات و النوتيلا و الاضافات",
                style: TextStyle(color:isdark??false? floatActionColor: borderColor), maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _bottomSheetController,
                itemCount: canAdd?topMenu.length:0,
                itemBuilder: (context,index)=>Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Text('${topMenu[index]}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),),
                    ),
                    SizedBox(
                      height:bottomMenu[index].length*55,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,otherIndex,){
                          final bool isChecked = checklist[index][otherIndex];
                          return checkList(isChecked,(bool? value) {
                            changeChecklistValue(index, otherIndex, value ?? false);
                          },
                          );},itemCount: bottomMenu[index].length,),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(
                margin: EdgeInsets.only(left: 20,bottom: 10),
                padding: EdgeInsets.all(10),
                width: MediaQuery.sizeOf(context).width/2,
                height: 50,
                decoration: BoxDecoration(
                  color: mainColor.shade400,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child:  InkWell(
                onTap: (){setState(() {
                  addValue(onTap,itemsNumber);
                  DeliveryCubit.get(context).submitValue(itemsNumber);
                  Navigator.pop(context);
                });},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Row(
                      children: [
                        Text(
                          dropdownvalue=='English Language'?'SAR':'ريال', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                          style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(
                          '6', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                          style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                       Text(
                         dropdownvalue=='English Language'?'Add cart':'اضافة', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                        style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                  ],
                ),
              ),
              ),
                addOrRemoveOne(itemsNumber, context, (){setState((){if(itemsNumber>=30){itemsNumber=30;}
                else{itemsNumber+=1;}},);}, (){setState((){if(itemsNumber<=1){itemsNumber=1;}
                else{itemsNumber-=1;}});
                },true),
            ],)
          ],
        ),
      ),
    );
  }
  Widget checkList(isChecked,onChange)=>CheckboxListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              dropdownvalue=='English Language'?'Sar':'ريال', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
            ),
            SizedBox(width: 5,),
            Text(
              '6+', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
            ),
          ],
        ),
        Text(
          'بيبسى', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
          style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
        ),
      ],
    ),
    value: isChecked,
    onChanged: onChange,
    activeColor: mainColor.shade400,
  );
}

