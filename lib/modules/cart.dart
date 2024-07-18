import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/login.dart';
import 'package:delivery/modules/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';


class Cart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController _noteTextController = TextEditingController();
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: dropdownvalue == 'English Language'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: AppBar(
            title: Text(dropdownvalue=='English Language'? 'Cart':'السلة',style: TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:[ Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: dropdownvalue=='English Language'?CrossAxisAlignment.start:CrossAxisAlignment.end,
                children: [
                  Text(dropdownvalue=='English Language'? 'Orders':'طلباتى',style: TextStyle(color:isdark??false ? floatActionColor: brownColor,fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,),),
                  Directionality(
                    textDirection: dropdownvalue=='English Language'?TextDirection.ltr : TextDirection.ltr,
                    child: SizedBox(
                      height: values.length*100,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context,index)=>seperate(),
                        itemCount: values.length,
                        itemBuilder: (context,index){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: image('${values[index]['image']}', 70.0, 60.0, 40.0,BoxFit.fill),
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${values[index]['name']}',maxLines: 2, overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                               SizedBox(height: 5,),
                                Text('${values[index]['price']} SR',maxLines: 1, overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          )),
                            Flexible(
                              child: addOrRemoveOne(
                                    values[index]['quantity'],
                                    context,
                                    (){ DeliveryCubit.get(context).addValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id'],values[index]['extraId']);},
                                    (){ DeliveryCubit.get(context).minusValue(values[index]['name'],1,values[index]['image'],values[index]['price'],values[index]['id']);
                                      if(values.isEmpty){Navigator.pop(context);}
                                      },
                                    false
                                ),
                              ),
                        ],);}
                      ),
                    ),
                  ),
                  seperate(),
                  Text(dropdownvalue=='English Language'? 'Order Notes':'ملاحظات الطلب',style: TextStyle(color:isdark??false ? floatActionColor: brownColor,fontFamily: 'fontTop',fontSize: 23,fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 15,),
                  TextFormField(
                    maxLines: 4,
                    minLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                      labelText:dropdownvalue=='English Language'? 'Add Notes' :'أضف تعليمات',
                      alignLabelWithHint: true,
                    ),
                    controller: _noteTextController,
                    onChanged: (text) {},
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return   CustomBottomSheet();});},
                    child: Directionality(
                      textDirection: dropdownvalue=='English Language'?TextDirection.rtl:TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            Text(dropdownvalue=='English Language'? "Item is unavailable":"فى حاله عم توفر الصنف",style: TextStyle(fontFamily: 'fontTop',color: isdark??false? floatActionColor:borderColor.shade700,fontWeight: FontWeight.w500,fontSize: 16),),
                            Text(choose? dropdownvalue=='English Language'?listTextEn[1]:listTextAr[1] :dropdownvalue=='English Language'?listTextEn[0]:listTextAr[0],style: TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.w500,fontSize: 18),),
                          ],),
                          SizedBox(width: 5,),
                          Icon(Icons.shopping_bag_outlined,size: 28,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0,top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(dropdownvalue=='English Language'?'SR' : 'ريال'),
                          ),
                          SizedBox(width: 5,),
                          Text('$price' ,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 17,fontWeight: FontWeight.w400,),),
                        ],
                      ),
                      Text(dropdownvalue=='English Language'?'Total order' : 'اجمالى الطلب',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 17,fontWeight: FontWeight.w400,),),
                    ],),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cartBottom(context,(){navigate(context,(token!=''&&token!=null)? Payment():Login());if(token==''||token==null)loginFromCart=true;print(values);},cartBottomColor.shade600,dropdownvalue=='English Language'? 'Pay now':'اذهب للدفع'),
                      cartBottom(context,(){Navigator.pop(context);},mainColor.shade400,dropdownvalue=='English Language'? 'Add new':'اضافه جديدة'),
                    ],
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  },
);
  }
  int? getValueByName(String name) {
    for (var map in values) {
      if (map.containsKey(name)) {
        return map[name];
      }
    }
    return null; // Return null if the name is not found
  }
  Widget cartBottom(context,onTap,color,text)=>InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: color ,borderRadius: BorderRadius.circular(10)),
      height: 50,
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width/2.3,
      child: Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontFamily: 'fontTop',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
    ),
  );
}
class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>  with SingleTickerProviderStateMixin {
  bool containerPadding=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void startAnimation() {
    setState(() {
      containerPadding =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(dropdownvalue=='English Language'?"Item unavailable":"صنف غير متوفر",style: TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.w500,fontSize: 18),),
          const SizedBox(height: 6,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Text(dropdownvalue=='English Language'?"confirm us what you want to do if items are unavailable":"صنف غير متوفر",style: TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.w100,fontSize: 15),),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: Directionality(
              textDirection: dropdownvalue=='English Language'? TextDirection.ltr:TextDirection.rtl,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context,index)=> ListTile(
                  leading: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.all(4),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: !containerPadding&&_isCheckedList[index]==true?mainColor.shade400:null,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1.2,color: isdark??false ?_isCheckedList[index]==true? mainColor.shade400:floatActionColor:_isCheckedList[index]==true?mainColor.shade400:borderColor)),
                      child: CircleAvatar(
                        radius:5,
                        backgroundColor: _isCheckedList[index]==true? mainColor.shade400: isdark??false ?Colors.black12:floatActionColor,
                      ),
                    ),
                  ),
                  title: Text(dropdownvalue=='English Language'?listTextEn[index]:listTextAr[index],style: TextStyle(fontSize: 17),),
                  onTap: (){
                        setState((){
                        if(index==1){_isCheckedList=[false,true];choose=true;}
                        else{_isCheckedList=[true,false];choose=false;}
                        DeliveryCubit.get(context).increment();
                        });
                        setState(() {
                        containerPadding =false;
                        });

                        Timer(Duration(milliseconds: 350), () {
                        setState(() {
                        containerPadding = true;
                        });
                        });
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
List<String> listTextAr =[ 'ازاله الصنف الغير متوفر','الغاء الطلب'];
List<String> listTextEn =[ 'Remove it from order','Cancel the order'];
bool choose=false;
List<bool> _isCheckedList =[ true,false];