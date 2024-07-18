import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
class ProviderPage extends StatefulWidget {
  var providetDescription;
  var providetName;
  var providetCover;
  var providetimage;

  ProviderPage({super.key,required this.providetDescription,required this.providetName,required this.providetCover,required this.providetimage});

  @override
  State<ProviderPage> createState() => _ProviderPage(providetDescription: providetDescription,providetName:providetName,providetCover: providetCover,providetimage: providetimage);
}

class _ProviderPage extends State<ProviderPage>with SingleTickerProviderStateMixin{
  late AnimationController controller;
  TextEditingController searchController = TextEditingController();
  bool showSearch=false;
  var providetDescription;
  var providetName;
  var providetCover;
  var providetimage;

  _ProviderPage({required this.providetDescription,required this.providetName,required this.providetCover,required this.providetimage});
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
    var menu= DeliveryCubit.get(context).providerFoodData;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children:[ Expanded(
                child: Container(
                  color:state is !GetProviderFoodLoading&&isdark!? Colors.grey.shade600:Colors.white,
                  child: CustomScrollView(
                    physics: state is !GetProviderFoodLoading?menu!.CategoriesItemsData!.length<1?NeverScrollableScrollPhysics():null:null,
                    controller: DeliveryCubit.get(context).scrollControllerColumn,
                    slivers: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500), // Set your desired duration
                      child: SliverAppBar(
                        leading: Container(),
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
                                  menu!=null&&state is !GetProviderFoodLoading?Row(
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
                                            itemCount: menu.CategoriesItemsData!.length,
                                            itemBuilder: (context, index) => InkWell(
                                              onTap: (){DeliveryCubit.get(context).scrollToIndex(index);},
                                              child: topBar(menu.CategoriesItemsData![index].name,index == DeliveryCubit.get(context).currentIndex ? mainColor.shade400 : isdark??false? Colors.black87:floatActionColor,
                                                  index == DeliveryCubit.get(context).currentIndex ? mainColor.shade300:isdark??false? floatActionColor:brownColor),
                                            ),
                                            itemScrollController: DeliveryCubit.get(context).itemScrollController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ):Row(children: [Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0),Skeleton(width: 50.0,height: 15.0)],),
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
                                  child:image('$providetCover', DeliveryCubit.get(context).imageHeight, double.infinity,0.0,BoxFit.cover),
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
                                              image('$providetimage', 40.0, 40.0, 40.0,BoxFit.fill),
                                              Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                child: Text('$providetName',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              ),
                                            ],),
                                          AnimatedOpacity(
                                              duration: Duration(milliseconds: 300), // Duration of the animation
                                              opacity: DeliveryCubit.get(context).opecity,
                                              child: Text("$providetDescription",style: TextStyle(color: isdark??false? floatActionColor:borderColor.shade500,fontWeight: FontWeight.w500,fontSize: 16),)),
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
                        sliver: menu!=null&&state is !GetProviderFoodLoading?menu.CategoriesItemsData!.isNotEmpty?SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ListTile(  horizontalTitleGap: 0,
                                title:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text('${menu.CategoriesItemsData![index].name}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isdark??false ? Colors.white:brownColor),),),
                              subtitle: Column(
                                crossAxisAlignment: dropdownvalue=='English Language'?CrossAxisAlignment.start:CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height:menu.CategoriesItemsData![index].items!.length*170,child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,indexNew) =>Column(
                                      crossAxisAlignment:dropdownvalue=='English Language'?CrossAxisAlignment.start: CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: (){bottomSheet(context, _CustomBottomSheet(onTap: '${menu.CategoriesItemsData![index].items![indexNew].name}',extra:menu.CategoriesItemsData![index].items![indexNew].extraItems,itemImage:menu.CategoriesItemsData![index].items![indexNew].image, name: menu.CategoriesItemsData![index].items![indexNew].name,description: menu.CategoriesItemsData![index].items![indexNew].description,price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}',),controller: controller);},
                                          child: menuItems(menu.CategoriesItemsData![index].items![indexNew].extraItems!.isNotEmpty?(){
                                            bottomSheet(context, _CustomBottomSheet(onTap: '${menu.CategoriesItemsData![index].items![indexNew].name}',extra:menu.CategoriesItemsData![index].items![indexNew].extraItems,itemImage:menu.CategoriesItemsData![index].items![indexNew].image, name: menu.CategoriesItemsData![index].items![indexNew].name,description: menu.CategoriesItemsData![index].items![indexNew].description,price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}'),controller: controller);}
                                              :(){DeliveryCubit.get(context).addValue('${menu.CategoriesItemsData![index].items![indexNew].name}',1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id,null);},menu.CategoriesItemsData![index].items![indexNew].extraItems!.length!=0?true : false,menu.CategoriesItemsData![index].items![indexNew],1,context,
                                              DeliveryCubit.get(context).isNameInList('${menu.CategoriesItemsData![index].items![indexNew].name}')? addOrRemoveOne(DeliveryCubit.get(context).getValueByName('${menu.CategoriesItemsData![index].items![indexNew].name}'), context, menu.CategoriesItemsData![index].items![indexNew].extraItems!.isNotEmpty?(){
                                              bottomSheet(context, _CustomBottomSheet(onTap: '${menu.CategoriesItemsData![index].items![indexNew].name}', extra:menu.CategoriesItemsData![index].items![indexNew].extraItems,itemImage:menu.CategoriesItemsData![index].items![indexNew].image, name: menu.CategoriesItemsData![index].items![indexNew].name,description: menu.CategoriesItemsData![index].items![indexNew].description,price: menu.CategoriesItemsData![index].items![indexNew].price,id: '${menu.CategoriesItemsData![index].items![indexNew].id}'),controller: controller,);}:(){DeliveryCubit.get(context).addValue('${menu.CategoriesItemsData![index].items![indexNew].name}', 1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id,null);},
                                              (){DeliveryCubit.get(context).minusValue('${menu.CategoriesItemsData![index].items![indexNew].name}', 1,menu.CategoriesItemsData![index].items![indexNew].image,menu.CategoriesItemsData![index].items![indexNew].price??0,menu.CategoriesItemsData![index].items![indexNew].id);},false):null)),
                                      ],
                                    )
                                    ,itemCount: menu.CategoriesItemsData![index].items!.length, separatorBuilder: (BuildContext context, int index) =>seperate(),)),
                                  if(index!=menu.CategoriesItemsData!.length-1&&index!=0)
                                    seperate(),
                                ],
                              ),
                            );
                          }, childCount: menu.CategoriesItemsData!.length,
                        ), ):SliverList(delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {return Center(child: Text('000000'),);},childCount: 1)):Directionality(
                            textDirection: TextDirection.rtl,
                            child: SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index){
                                  return ListTile(
                                    subtitle: Column(
                                      children: [
                                        SizedBox(height:700,child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context,indexNew) =>Container(
                                            height: 135,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Skeleton(width: 120.0,height: 20.0),
                                                  Skeleton(width: 150.0,height: 10.0),
                                                  Skeleton(width: 190.0,height: 10.0),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Skeleton(width: 50.0,height: 10.0),const SizedBox(width: 5,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:8.0,right: 8),
                                                        child: Skeleton(width: 50.0,height: 10.0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Skeleton(width: 100.0,height: 110.0),
                                            ],),
                                          ),itemCount: 3, separatorBuilder: (BuildContext context, int index) =>seperate(),)),
                                          seperate()
                                      ],
                                    ) ,
                                  );
                                }, childCount: 1,
                              ), ),
                        ),
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
                          style: TextStyle(color: Colors.black87),
                          autofocus: true,
                          controller: searchController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter amount to stake',
                            hintStyle: TextStyle(color: Colors.grey), // Change the hint text color
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close,color: Colors.grey),
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
   var itemImage;
   var name;
   var id;
   var price;
   var description;
   var extra;
   @override
  _CustomBottomSheet({required this.onTap,required this.extra,required this.itemImage,required this.name,required this.description,required this.price,required this.id});
  _CustomBottomSheetState createState() => _CustomBottomSheetState( onTap:onTap,extra: extra,itemImage: itemImage,name: name,description: description,price: price,id: id);
}

class _CustomBottomSheetState extends State<_CustomBottomSheet> {
  Color containerColor = Colors.white;
  ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;
  int itemsNumber=1;
  int totalExtraPrice=0;
  String  ExtraName='';
  List  addExtra=[];
  late double imageBottomSheetHeight=MediaQuery.sizeOf(context).height/4;
   var onTap;
  var itemImage;
  var name;
  var id;
  var description;
  var price;
  var extra;
  List<List<bool>> checklist = [];
  _CustomBottomSheetState({required this.onTap,required this.extra,required this.itemImage,required this.name,required this.description,required this.price,required this.id});
  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] = value;
    });
  }
  @override
  void initState() {
    super.initState();
    _bottomSheetController.addListener(bottomSheetScroll);
    checklist = List.generate(
      extra.length,
          (index) => List.filled(extra.length, false),
    );
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height-120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300), // Duration of the animation
              height: imageBottomSheetHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10) ),
                  image: DecorationImage(
                      image: NetworkImage(itemImage),
                      fit:BoxFit.cover
                  )),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
              ),),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(
                name, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:isdark??false? floatActionColor: brownColor),
              ),
            ),
             Padding(
              padding:const EdgeInsets.only(left:15.0,right: 15),
              child: Text(
                description,
                textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
                style: TextStyle(color:isdark??false? floatActionColor: borderColor), maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _bottomSheetController,
                itemCount: extra.length!=0?1:0,
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Text('${topMenu[index]}',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),),
                      ),
                      SizedBox(
                        height:extra.length*55.0,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,otherIndex,){
                            final bool isChecked = checklist[index][otherIndex];
                            return checkList(isChecked,(bool? value) {
                              changeChecklistValue(index, otherIndex, value ?? false);
                              if (value ?? false) {
                                totalExtraPrice += (itemsNumber*extra[otherIndex].price).toInt();
                               if(!ExtraName.contains(extra[otherIndex].name))
                                ExtraName+='+${extra[otherIndex].name}';
                               addExtra.add('${extra[otherIndex].id}');
                               print(addExtra);
                              } else {
                                totalExtraPrice -= (itemsNumber*extra[otherIndex].price).toInt();
                                 ExtraName = ExtraName.replaceAll('+${extra[otherIndex].name}', '');
                                addExtra.remove('${extra[otherIndex].id}');
                                print(addExtra);
                              }
                            },'${extra[otherIndex].name}','${extra[otherIndex].price}',extra[otherIndex].image
                            );},itemCount: extra.length,),
                      ),
                    ],
                  );}
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
                  DeliveryCubit.get(context).addValue('${onTap+ExtraName}',itemsNumber,itemImage,price*itemsNumber+totalExtraPrice*itemsNumber,id,addExtra);
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
                          '${price*itemsNumber+totalExtraPrice*itemsNumber}', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                          style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                       Row(
                         children: [
                           Text(
                             dropdownvalue=='English Language'?'Add cart':'اضافة', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                            style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                           ),
                         ],
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
  Widget checkList(isChecked,onChange,addNewName,price,extraImage)=>CheckboxListTile(
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
              '$price+', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              addNewName, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: isdark??false? floatActionColor:brownColor),
            ),
            SizedBox(width: 7,),
            image('$extraImage', 30.0, 30.0, 30.0,BoxFit.fill),
          ],
        ),
      ],
    ),
    value: isChecked,
    onChanged: onChange,
    activeColor: mainColor.shade400,
      checkColor:Colors.white
  );
}

