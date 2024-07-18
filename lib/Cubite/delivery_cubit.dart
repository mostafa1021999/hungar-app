import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/models/categories%20provider.dart';
import 'package:delivery/models/coupon%20model.dart';
import 'package:delivery/models/get%20user%20data.dart';
import 'package:delivery/models/login%20model.dart';
import 'package:delivery/models/offers model.dart';
import 'package:delivery/models/otpModel.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../componants/componants.dart';
import '../models/Categories model.dart';
import '../models/provider items model.dart';
import '../models/provider model.dart';
import '../modules/home.dart';
part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial()){
    _getCurrentLocation();
    scrollControllerColumn.addListener(_onScroll);
    scrollControllerColumn.addListener(_scrollAnimation);
    if(providerFoodData!=null)
    _calculateListOffsets();
  }
  int current = 3;
  int advertising = 0;
  String otp='';
  bool changeViewNew=false;
  String currentLocationName='';
  double ?position1;
  double ?position2;
  //============Resturant=================
  final ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  final ItemScrollController itemScrollController = ItemScrollController();
  double expandedHeight = 345.0;
  double imageHeight=200.0;
  double containerHeight=180.0;
  double containerPadding = 100.0;
  double rowItems=150;
  double opecity=1;
  int currentIndex = 0;
  //======================================
  static DeliveryCubit get(context) => BlocProvider.of(context);
  List<BluredNavBarXItem> bottomAr = [
    BluredNavBarXItem(icon: Icons.more_horiz,
      title: 'المزيد',
    ),
    BluredNavBarXItem(icon: Icons.card_giftcard,
      title: 'نقاطى',
    ),
    BluredNavBarXItem(icon: Icons.apps_outlined,
      title: 'طلباتى',
    ),
    BluredNavBarXItem(icon:  Icons.home,
      title: 'الرئيسيه',
    ),
  ];
  List<BluredNavBarXItem> bottomEn = [
    BluredNavBarXItem(icon: Icons.more_horiz,
      title: 'More',
    ),
    BluredNavBarXItem(icon: Icons.card_giftcard,
      title: 'Points',
    ),
    BluredNavBarXItem(icon: Icons.shop,
      title: 'My Orders',
    ),
    BluredNavBarXItem(icon:  Icons.home,
      title: 'Home',
    ),
  ];
  void increment(){
    emit(Reload());
  }
  //===============resturant=============
  _scrollAnimation(){
    final double offset = scrollControllerColumn.offset;
      if (offset > 20 && offset < 50) {
        imageHeight = 200 - offset;
        containerPadding = 100 - offset * 0.0002;
        containerHeight = 180 - offset * 2.5;
        if (expandedHeight > 150) {
          expandedHeight -= offset * 0.1;
        }
        rowItems = 150 - offset;
        if (opecity > 0.2) {
          opecity -= 0.2;
        } else {
          opecity = 0;
        }
      } else if (offset <= 20) {
        imageHeight = 200 - offset * 0.002;
        containerPadding = 100.0;
        containerHeight = 180 - offset * 1.9;
        rowItems = 150.0;
        opecity = 1.0;
        expandedHeight = 345.0;
      } else {
        opecity = 0;
        expandedHeight = 150;
        containerHeight = 64;
      }
    emit(Reload());
  }
  List<int> listOffsets = [];
  void _calculateListOffsets() {
    int offset = 0;
    for (int i = 0; i < providerFoodData!.CategoriesItemsData!.length; i++) {
      listOffsets.add(offset);
      offset += providerFoodData!.CategoriesItemsData![i].items!.length * 140;
    }
  }

  void _onScroll() {
    final itemHeight = 150; // Replace with the actual height of each item
    final offset = scrollControllerColumn.offset;
    int? currentIndexNew;

    _calculateListOffsets(); // Call _calculateListOffsets() before using listOffsets

    if (listOffsets.isNotEmpty) {
      for (int i = 0; i < listOffsets.length; i++) {
        final startOffset = listOffsets[i];
        final endOffset = startOffset + providerFoodData!.CategoriesItemsData![i].items!.length * itemHeight;

        if (offset >= startOffset && offset < endOffset) {
          currentIndexNew = i;
          break;
        }
      }
      // Check if the scrollControllerColumn is at the last page
      final totalHeight = listOffsets.last + providerFoodData!.CategoriesItemsData![listOffsets.length - 1].items!.length * itemHeight;
      if (scrollControllerColumn.position.pixels >= totalHeight - scrollControllerColumn.position.viewportDimension) {
        currentIndexNew = providerFoodData!.CategoriesItemsData!.length; // Set currentIndexNew to 4 if the scrollControllerColumn is at the last page
      }
      if (currentIndexNew != currentIndex) {
        currentIndex = currentIndexNew!;
          Timer(Duration(milliseconds: 200), () {
            itemScrollController.jumpTo(index: currentIndex, alignment:currentIndex==0||currentIndex==1? 0.0:0.3);
          });
      }
    }
    emit(Reload());
  }

  int calculateItemsBeforeIndex(int foodIndex) {
    int totalItems = 0;
    if (providerFoodData!.CategoriesItemsData!.isNotEmpty && foodIndex >= 0 && foodIndex < providerFoodData!.CategoriesItemsData!.length) {
      for (int i = 0; i < foodIndex; i++) {
        totalItems += providerFoodData!.CategoriesItemsData![i].items!.length;
      }
    }
    return totalItems;
  }

  void scrollToIndex(int index) {
    int items = calculateItemsBeforeIndex(index);
    scrollController.animateTo(
      items * 150, // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeOut, // Adjust the curve as per your preference
    );
    emit(Reload());
  }
  void addValue(String name, int value,image,int foodPrice,id,extraId) {
    bool valueExists = false;
    for (var map in values) {
      if (map['name'] == name) {
        map['quantity'] = (map['quantity']! + 1);
        valueExists = true;
        break;
      }
    }
    if (!valueExists) {
      values.add({
        'name': name,
        'quantity': value,
        'image': image,
        'price': foodPrice,
        'id': id,
        'extraItems': extraId
      });
      print(values);
    }
    price+=foodPrice;
    emit(Reload());
  }

  void minusValue(String name, int value, image, int foodPrice,id) {
    bool valueExists = false;
    for (var map in values) {
      if (map['name'] == name) {
        map['quantity'] = (map['quantity']! - 1);
        if (map['quantity'] == 0) {
          values.remove(map);
        }
        valueExists = true;
        break;
      }
    }

    if (valueExists) {
      price -= foodPrice;
      emit(Reload());
    }
  }
  bool isNameInList(String name) {
    for (var map in values) {
      if (map['name'] == name) {
        return true;
      }
    }
    return false;
  }

  int? getValueByName(String name) {
    for (var map in values) {
      if (map['name'] == name) {
        return map['quantity'];
      }
    }
    return null;
  }
  //======================================================
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SystemNavigator.pop();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
        position1=position.latitude;
        position2=position.longitude;
      changeLocation(currentLocationName,position1,position2);
        currentLocationName = '${placemark.street??''},${placemark.locality}, ${placemark.country}';
    } catch (e) {
      SystemNavigator.pop();
      print(e);
    }
  }
  void changeLocation(newLocation,first,second){
    currentLocationName=newLocation;
    position1=first;
    position2=second;
    emit(Reload());
  }
  void changeNavigator(int index) {
    current = index;
    emit(OtherPage());
  }
  void changeAdds(int index) {
    advertising = index;
    emit(OtherPage());
  }
  void changeView() {
    changeViewNew = !changeViewNew;
    emit(CategoryProviderSuccess());
  }
  OffersModel? offersData;
  Map<int?, bool?> favorites={};
  Map<int?, bool?> carts={};
  void offers(){
    emit(OffersLoading());
    DioHelper.getData(url: 'home',
      token: "y6h6jwH610mVxvdY5Xrenu8e4lULiQ80YzE0MnCjeNGYU4pxumL5fPLUYLjTEYmX1UIIR0",
      myapp: false,
    ).then((value) {
      offersData=OffersModel.fromJson(value.data);
      emit(OffersSuccess());
    }).catchError((error) {
      print("errrrrrrrrrrrrrr");
      emit(OffersError());
    });
  }
  void submitValue(value) {
    emit(SubmitValueEvent(value));
  }
  List<bool> isCheckedList =[ true,false,false];
  bool choosePadding =true;

  void changePaymentMethod(index){
    if(index==1){isCheckedList=[false,true,false];emit(Reload());}
    else if(index==2){isCheckedList=[false,false,true];emit(Reload());}
    else {isCheckedList=[true,false,false];emit(Reload());}
    choosePadding =false;
  Timer(Duration(milliseconds: 350), () {
    choosePadding = true;
    emit(Reload());
  });
}
  List<Categories> ?categoryData;
  void category() {
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories', myapp: true)
        .then((value) {
      final List<dynamic> categories = value.data;
      categoryData = categories.map((item) => Categories.fromJson(item)).toList();
      print('trrrrrrrrrrrrrrrr');
      emit(CategoriesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesError());
    });
  }

  CategoryProviderModel? categoryProvideData;
  void categoryProvider(id) {
    emit(CategoryProviderLoading());
    DioHelper.getData(url: 'categories/$id', myapp: true)
        .then((value) {
      categoryProvideData = CategoryProviderModel.fromJson(value.data);
      print('trrrrrrrrrrrrrrrr');
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryProviderError());
    });
  }

  LoginUser ?loginUser;
  void userLogin({
    required String phoneNumber,
  }){
    emit(LoginLoading());
    DioHelper.postData(url: 'customers/generate-otp', data: {
      'phoneNumber' : phoneNumber,
    }).then((value) {
      loginUser= LoginUser.fromJson(value.data);
      emit(LoginSuccess());
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }
  LoginOTP ?loginOTP;
  void userLoginOTP({
    required String phoneNumber,
    required String otpNumber,
    required context
  }){
    otp=otpNumber;
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/verify-otp', data: {
      'phoneNumber' : phoneNumber,
      'otp':otpNumber
    }).then((value) {
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      getNewCustomer(context);
      emit(LoginOTPSuccess());
    }).catchError((error) {
      emit(LoginOTPError());
    });
  }
  void changeLanguage(language){
    dropdownvalue = language;
    emit(ChangeLanguageSuccess());
  }

  GetUserData ?getUserData;
  Balance ?balanceData;
  void getNewCustomer(context){
    emit(GetUserLoading());
    DioHelper.getData(url: 'customers/auth/me',
      token: token,
    myapp: true
    ).then((value) {
      getUserData=GetUserData.fromJson(value.data);
      print(value.data);
      DioHelper.getData(url: 'wallet/${getUserData!.id}/balance',myapp: true).then((newValue) async {
            balanceData=Balance.fromJson(newValue.data);
            balances=await Save.savedata(key: 'balance',value:balanceData!.balance) ;
            emit(GetUserSuccess());
      });
    }).catchError((error) {
      emit(GetUserError());
    });
  }
  void userInvitation(){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/generate-invitation-code', token: token, data: {}).then((value) {
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      emit(LoginOTPSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginOTPError());
    });
  }
  void userUpdate({
    String ?username ,
    String ?email ,
    String ?birthdate ,
    context
  }){
    emit(UpdateUserLoading());
    Map<String, dynamic> data = {}; // Create an empty map to hold the updated data
    if (username != null) {data['name'] = username;}
    if (email != null) {data['email'] = email;}
    if (birthdate != null) {data['birthday'] = birthdate;}
    DioHelper.patchData(url: 'customers/auth/me',token: token,data:data).then((value) {
      DioHelper.getData(url: 'customers/auth/me',
          token: token,
          myapp: true
      ).then((value) {
        getUserData=GetUserData.fromJson(value.data);
        print(value.data);
      });
      emit(UpdateUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserError());
    });
  }
  Provider? providerData;
  void getProviderData(){
    emit(GetProviderLoading());
    DioHelper.getData(url: 'providers',
        myapp: true
    ).then((value) {
      providerData = Provider.fromJson(value.data);
        emit(GetProviderSuccess());
      }).catchError((error) {
      emit(GetProviderError());
    });
  }
  ProviderItemsMenu? providerFoodData;
  void getProviderFoodData(id) {
    emit(GetProviderFoodLoading());
    DioHelper.getData(url: 'providers/$id', myapp: true)
        .then((value) {
      providerFoodData=ProviderItemsMenu.fromJson(value.data);
      print(value.data);
      emit(GetProviderFoodError());
    })
        .catchError((error) {
      print(error.toString());
      emit(GetProviderFoodError());
    });
  }
  Coupon ?couponData;
  void postCoupon({
    required String coupon,
    required int orderPrice,
    required int shippingPrice,
    context
  }){
    emit(CouponLoading());
    DioHelper.postData(url: 'coupons/validate', data: {
      'code' : coupon,
      'orderPrice':orderPrice,
      'shippingPrice':shippingPrice
    }).then((value) {
      couponData=Coupon.fromJson(value.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Text(dropdownvalue=='English Language'?"Coupon add successfully":'تم اضافه الكوبون بنجاح',style: TextStyle(color: Colors.white),),
      ));
      Navigator.pop(context);
      emit(CouponSuccess());
    }).catchError((error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Text(dropdownvalue=='English Language'?"Coupon is not valid":'الكوبون ليس صحيح',style: TextStyle(color: Colors.white),),
      ));
      Navigator.pop(context);
      emit(CouponError());
    });
  }
  void postOrder({
    String? coupon,
    required List items,
    required int shippingPrice,
    required String customerId,
    context
  }){
    emit(PostOrderLoading());
    DioHelper.postData(url: 'orders', data: {
      'coupon' : coupon,
      'items':items,
      'shippingPrice':shippingPrice,
      'customerId':customerId,
      'location': {
        "type": "Point",
        "coordinates": [
          position1,
          position2
        ]
      },
    }).then((value) {
      pageController=PageController(initialPage: 2);
      DeliveryCubit.get(context).changeNavigator(2);
      DeliveryCubit.get(context).couponData=null;
      navigateAndFinish(context, Home());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(dropdownvalue=='English Language'?'Order has been done successfully':"تم تنفيذ الطلب بنجتح",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      emit(PostOrderSuccess());
    }).catchError((error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Text(dropdownvalue=='English Language'?"Failed to execute the order":'فشل تنفيذ الاوردر',style: TextStyle(color: Colors.white),),
      ));
      emit(PostOrderError());
    });
  }
}

