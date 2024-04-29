import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/modules/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Restaurant extends StatefulWidget {
  @override
  _Restaurant createState() => _Restaurant();
}
class _Restaurant extends State<Restaurant> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  double _expandedHeight = 345.0;
  double imageHeight=200.0;
  double containerHeight=180.0;
  double containerPadding = 100.0;
  double rowItems=150;
  double opecity=1;
  int _currentIndex = 0;
  ScrollController _listviewController = ScrollController();
  ScrollController _bottomSheetController = ScrollController();
  List<int> _listOffsets = [];
  bool isChecked = false;
  late AnimationController controller;

  late double imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4;

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    _scrollController.addListener(_onScroll);
    controller.duration = Duration(milliseconds: 700);
    _calculateListOffsets();
  }
  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    _bottomSheetController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final double offset = notification.metrics.pixels;

            setState(() {
              if (offset > 20 && offset < 50) {
                imageHeight = 188 - offset;
                containerPadding = 100 - offset * 0.0002;
                containerHeight = 180 - offset * 2.5;
                if (_expandedHeight > 150) {
                  _expandedHeight -= offset * 0.1;
                }
                rowItems = 150 - offset;
                if (opecity > 0.2) {
                  opecity -= 0.2;
                } else {
                  opecity = 0;
                }
              } else if (offset <= 20) {
                imageHeight = 188 - offset * 0.002;
                containerPadding = 100.0;
                containerHeight = 180 - offset * 1.9;
                rowItems = 150.0;
                opecity = 1.0;
                _expandedHeight = 345.0;
              } else {
                opecity = 0;
                _expandedHeight = 150;
                containerHeight = 64;
              }
            });
          }
          return true;
        },
        child:Column(
          children:[ Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500), // Set your desired duration
                child: SliverAppBar(
                  expandedHeight: _expandedHeight,
                    bottom: PreferredSize(preferredSize: Size.fromHeight(240),child: Card(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: double.infinity,color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                 Icon(Icons.search,color: brownColor,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(topMenu.length, (index) =>InkWell(
                                        onTap: (){scrollToIndex(index);},
                                        child: topBar(topMenu[index],index == _currentIndex ? mainColor.shade400 : Colors.white,
                                            index == _currentIndex ? Colors.white:brownColor))
                                    ),),
                                ],
                              ),
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
                            height: imageHeight,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/logoApp.jpg"),
                                    fit: BoxFit.cover)),
                            child: Container(
                              padding: EdgeInsets.only(top: 90, left: 20),
                              color: Color(0xFF3b5999).withOpacity(.40),
                            ),
                          ),
                          AnimatedPadding(
                              duration: Duration(milliseconds: 200), // Duration of the animation
                              padding: EdgeInsets.only(top: containerHeight==180? containerPadding+100:containerPadding+40),
                              child: Container(width: double.infinity,color: Colors.white,height:containerHeight,)),
                          AnimatedPadding(
                            duration: Duration(milliseconds: 200), // Duration of the animation
                            padding: EdgeInsets.only(top: containerPadding),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200), // Duration of the animation
                              padding: EdgeInsets.all(10),
                              height:containerHeight,
                              width: MediaQuery.of(context).size.width-38,
                              margin: EdgeInsets.only(left: 20,right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.3),
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
                                          child: Text('بلبن',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 25,fontWeight: FontWeight.bold),),
                                        ),
                                      ],),
                                    AnimatedOpacity(
                                        duration: Duration(milliseconds: 300), // Duration of the animation
                                        opacity: opecity,
                                        child: Text("لبن زايدينه حلى",style: TextStyle(fontFamily: 'fontTop',color: borderColor,fontWeight: FontWeight.w500,fontSize: 18),)),
                                    Container(height: 40,), // Add the Spacer widget
                                    AnimatedOpacity(
                                      duration: Duration(milliseconds: 500), // Duration of the animation
                                      opacity: opecity,
                                      child:const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Column(children: [Text("مدة التوصيل",style: TextStyle(color: brownColor,fontWeight: FontWeight.bold,),),
                                              Text('20 - 30 دقيقة',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: brownColor),),
                                            ],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Column(children: [Text("رسوم التوصيل",style: TextStyle(color: brownColor,fontWeight: FontWeight.bold,),),
                                              Text('0 - 15 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: brownColor),),
                                            ],),
                                          ),Column(children: [Text("الحد الادنى للطلب",style: TextStyle(color: brownColor,fontWeight: FontWeight.bold,),),
                                            Text('20 SAR',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: brownColor),),
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return ListTile(  horizontalTitleGap: 0,
                        title:Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text('${topMenu[index]}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: brownColor),)),
                      subtitle: SizedBox(height:bottomMenu[index].length*130+20,child: ListView.builder(
                        controller: _listviewController,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,indexNew) =>menuItems(index%2==0?(){showModalBottomSheet(
                            transitionAnimationController: controller,
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return _CustomBottomSheet(onTap: '${bottomMenu[index][indexNew]}');});}
                            :(){setState((){addValue('${bottomMenu[index][indexNew]}',1);
                        print(values);
                              });},index%2==0?true : false,index,indexNew,1,context,
                            isNameInList(bottomMenu[index][indexNew])? addOrRemoveOne(getValueByName(bottomMenu[index][indexNew]), context, index%2==0?(){showModalBottomSheet(
                                transitionAnimationController: controller,
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return _CustomBottomSheet(onTap: '${bottomMenu[index][indexNew]}');});}:(){addValue('${bottomMenu[index][indexNew]}', 1);}, (){minusValue('${bottomMenu[index][indexNew]}', 1);},false):null)
                        ,itemCount: bottomMenu[index].length,)) ,
                    );
                  }, childCount: topMenu.length,
                ), ),
            ],
                  ),
          ),
             if(values.isNotEmpty)
             Padding(
               padding: const EdgeInsets.only(bottom: 10.0,top: 10),
               child: InkWell(
                 onTap: (){navigate(context,const Cart());},
                 child: Container(
                   decoration: BoxDecoration(color: cartBottomColor.shade400,borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: MediaQuery.sizeOf(context).width/1.1,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                   Row(
                     children: [
                       Text('ريال',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                       SizedBox(width: 5,),
                       Text('5',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                     ],
                   ),
                   Text('عرض السله',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                 ],),
                 ),
               ),
             ),
          ]
        ),
    ));
  },
);
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
  void minusValue(String name, int value) {
    setState(() {
      bool valueExists = false;
      for (var map in values) {
        if (map.containsKey(name)) {
          map[name] = (map[name]! - 1); // Subtract 1 instead of adding 1
          if (map[name] == 0) {
            values.remove(map); // Remove entry from map if value is 0
          }
          valueExists = true;
          break;
        }
      }
      if (!valueExists) {
        values.add({name: value});
      }
    });
  }
  bool isNameInList(String name) {
    for (var map in values) {
      if (map.containsKey(name)) {
        return true;
      }
    }
    return false;
  }
  int? getValueByName(String name) {
    for (var map in values) {
      if (map.containsKey(name)) {
        return map[name];
      }
    }
    return null; // Return null if the name is not found
  }
  void _calculateListOffsets() {
    int offset = 0;
    for (int i = 0; i < bottomMenu.length; i++) {
      _listOffsets.add(offset);
      offset += bottomMenu[i].length * 150;
    }
  }
  void scrollToIndex(index) {
    int items=calculateTotalLength(bottomMenu,index);
    _scrollController.animateTo(
      items * 150, // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeInOut, // Adjust the curve as per your preference
    );
  }
  void _onScroll() {
    final itemHeight = 150; // Replace with the actual height of each item
    final offset = _scrollController.offset;
    int ?currentIndex;
    for (int i = 0; i < _listOffsets.length; i++) {
      final startOffset = _listOffsets[i];
      final endOffset = startOffset + bottomMenu[i].length * itemHeight;

      if (offset >= startOffset && offset < endOffset) {
        currentIndex = i;
        break;
      }
    }

    if (currentIndex != _currentIndex) {
      setState(() {
        _currentIndex = currentIndex!;
      });
    }
  }

}

class _CustomBottomSheet extends StatefulWidget {
   var onTap;

  @override

  _CustomBottomSheet({required this.onTap});
  _CustomBottomSheetState createState() => _CustomBottomSheetState( onTap:onTap);
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  Color containerColor = Colors.white;
  ScrollController _bottomSheetController = ScrollController();
  bool isChecked = false;
  late AnimationController controller;
  int itemsNumber=1;
  late double imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4;
   var onTap;

  _CustomBottomSheetState({required this.onTap});

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
                style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: brownColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left:15.0,right: 15),
              child: Text(
                "رز بلبن بالمكسرات و النوتيلا و الاضافات",
                style: TextStyle(color: borderColor), maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _bottomSheetController,
                itemCount: topMenu.length,
                itemBuilder: (context,index)=>Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Text('${topMenu[index]}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: brownColor),),
                    ),
                    SizedBox(
                      height:bottomMenu[index].length*55,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,otherIndex)=>checkList(isChecked,(bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });}),itemCount: bottomMenu[index].length,),
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
                    const Row(
                      children: [
                        Text(
                          'ريال', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                          style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(
                          '6', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                          style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                       Text(
                        'اضافة', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
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
              'ريال', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: brownColor),
            ),
            SizedBox(width: 5,),
            Text(
              '6+', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: brownColor),
            ),
          ],
        ),
        Text(
          'بيبسى', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
          style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: brownColor),
        ),
      ],
    ),
    value: isChecked,
    onChanged: onChange,
    activeColor: mainColor.shade400,
  );
}
