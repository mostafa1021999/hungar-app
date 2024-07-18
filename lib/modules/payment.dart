import 'dart:async';

import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/cart.dart';
import 'package:delivery/modules/home.dart';
import 'package:delivery/modules/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    Positioned? _centerIcon;
    GoogleMapController? _mapController;
    Future<void> _setCenterMarker() async {
      LatLngBounds visibleRegion = await _mapController!.getVisibleRegion();
      LatLng centerPoint = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
        (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
      );
        _centerIcon = Positioned(
          left: MediaQuery.of(context).size.width / 2 - 22,
          top: MediaQuery.of(context).size.height / 2 - 160,
          child: Image.asset(
            'assets/pin.png',
            width: 48,
            height: 48,
          ),
        );
    }
    return Directionality(
      textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(dropdownvalue=='English Language'?'Review order':'مراجعه الطلب'),leading: InkWell(onTap:(){if(loginFromCart){Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);loginFromCart=false;}else{Navigator.pop(context);}},child: Icon(Icons.arrow_back_outlined)),),
          body:Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: ListView(children: [
                    Text(dropdownvalue=='English Language'?'Order details' :'تفاصيل الطلب',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: isdark??false? floatActionColor:brownColor),),
                    SizedBox(height: 8,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color:
                      borderColor)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Icon(Icons.more_time_rounded,color: isdark??false ?floatActionColor:brownColor,),
                        Text(dropdownvalue=='English Language'?'Expected timer' :'مدة توصيل المتوقعه',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color:isdark??false? floatActionColor: brownColor.shade300),),
                        Text(dropdownvalue=='English Language'?'10 - 20 Minutes' :'10 - 20 دقيقة ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: isdark??false? floatActionColor:brownColor),),
                      ],),
                    ),SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color: borderColor)),
                      height: 250,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 170,
                                child: GoogleMap(
                                  scrollGesturesEnabled:false,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(DeliveryCubit.get(context).position1??0, DeliveryCubit.get(context).position2??0),
                                    tilt: 59.440717697143555,
                                    zoom: 14.4746),),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width / 2 - 22,
                                top: 40,
                                child: Image.asset(
                                  'assets/pin.png',
                                  width: 48,
                                  height: 40,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 25.0, color: Colors.red,),
                              SizedBox(width: 10,),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dropdownvalue=='English Language'?'Order Location':'موقع الطلب',style: TextStyle(color: isdark??false ?floatActionColor:brownColor,fontSize: 17),),
                                  Text( DeliveryCubit.get(context).currentLocationName!=''?'${DeliveryCubit.get(context).currentLocationName}':dropdownvalue=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color:isdark??false? floatActionColor:brownColor.shade300),),
                                ],
                              )),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          pageController=PageController(initialPage: 3);
                          navigateAndFinish(context, Home());},
                        child: Container(
                          decoration: BoxDecoration( color: Colors.grey.shade300, borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.all(5),
                          child: Text(dropdownvalue=='English Language'?'change':'تغيير',style: TextStyle(color: brownColor,fontSize: 17,),),),
                      )
                            ],),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(dropdownvalue=='English Language'?'Payment details' :'تفاصيل الدفع',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: isdark??false? floatActionColor:brownColor),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color: borderColor)),
                      height: 270,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context,index)=> ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(listIcons[index]),
                                  SizedBox(width: 8,),
                                  Column(children: [
                                    Text(dropdownvalue=='English Language'?listTextEn[index]:listTextAr[index],style: TextStyle(fontSize: 17),),
                                    if(index==2)
                                    Row(
                                      children: [
                                        Text('ر.س',style: TextStyle(fontSize: 16),),
                                        SizedBox(width: 5,),
                                        Text(balances!=null?'$balances':'0.0',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),),
                                      ],
                                    )
                                  ],)
                                ],
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                padding: EdgeInsets.all(4),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: !DeliveryCubit.get(context).choosePadding&&DeliveryCubit.get(context).isCheckedList[index]==true?mainColor.shade400:null,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1.2,color: isdark??false ?DeliveryCubit.get(context).isCheckedList[index]==true? mainColor.shade400:floatActionColor:DeliveryCubit.get(context).isCheckedList[index]==true?mainColor.shade400:borderColor)),
                                  child: CircleAvatar(
                                    radius:5,
                                    backgroundColor: DeliveryCubit.get(context).isCheckedList[index]==true? mainColor.shade400: isdark??false ?Colors.black12:floatActionColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap:(){ DeliveryCubit.get(context).changePaymentMethod(index);},
                        ),
                        separatorBuilder:(context,index)=> seperate(),
                      ),
                    ),
                  ],),
                ),
              ),
              Directionality(
                textDirection: dropdownvalue=='English Language'?TextDirection.rtl:TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: dropdownvalue=='English Language'?MainAxisAlignment.start:MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){enterCoupon(context);},
                      child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: mainColor.shade400,borderRadius: BorderRadius.circular(8)),
                      width: 140,
                        child: Row(children: [
                          Text(dropdownvalue=='English Language'?'Add coupon':'أضافه كوبون',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                          Icon(Icons.control_point,size: 27,),
                        ],),
                      ),
                    ),
                  ],),
                ),
              ),
              state is PostOrderLoading?
              SpinKitWave(
                color:isdark??false? Colors.white:borderColor,
                size: 25.0,
              )
              :Directionality(
                textDirection: dropdownvalue=='English Language'?TextDirection.rtl:TextDirection.ltr,
                child: cartPaymentBottom(dropdownvalue=='English Language'?'Confirm order':'تنفيذ الطلب', (){
                  DeliveryCubit.get(context).postOrder(items: values, shippingPrice: price, customerId: '${DeliveryCubit.get(context).getUserData!.id}',coupon: '${_couponController.text}',context: context);
                }, context),
              ),
            ],
          )
      ),
    );
  },
);
  }
}
final TextEditingController _couponController = TextEditingController();

Future<void> enterCoupon(context) async {

  await showDialog(
    context: context,
    builder: (context) {
      return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {},
  builder: (context, state) {
    List<Widget> actions = [];

    if (state is CouponLoading) {
      actions = [
        SpinKitWave(
          color:isdark??false? Colors.white:borderColor,
          size: 25.0,
        )
      ];
    } else {
      actions = [
        bottom(
          dropdownvalue == 'English Language' ? 'Add' : 'اضافه',
              () {
            DeliveryCubit.get(context).postCoupon(
              coupon: _couponController.text,
              orderPrice: price,
              shippingPrice: 10,
              context: context,
            );
          },
        )
      ];
    }
    return AlertDialog(
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width/1.2,
          child: TextField(
            autofocus: true,
            controller: _couponController,
            decoration: InputDecoration(
              hintText: dropdownvalue=='English Language'?'Enter coupon code':"اضف الكوبون",
            ),
          ),
        ),
        actions: actions,
      );
  },
);
    },
  );
}
List<IconData> listIcons=[Icons.credit_card,Icons.apple_outlined,Icons.account_balance_wallet_rounded];
List<String> listTextAr =[ 'دفع فيذة','Apple Pay','المحفظة'];
List<String> listTextEn =[ 'Pay with Visa','Apple Pay','Teslm Cash'];