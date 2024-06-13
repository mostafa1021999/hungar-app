import 'dart:async';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/models/Categories%20model.dart';
import 'package:delivery/models/get%20user%20data.dart';
import 'package:delivery/models/login%20model.dart';
import 'package:delivery/models/offers model.dart';
import 'package:delivery/models/otpModel.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../componants/componants.dart';
part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial()){
    _getCurrentLocation();
    scrollControllerColumn.addListener(_onScroll);
    scrollControllerColumn.addListener(_scrollAnimation);
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
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  double expandedHeight = 345.0;
  double imageHeight=200.0;
  double containerHeight=180.0;
  double containerPadding = 100.0;
  double rowItems=150;
  double opecity=1;
  int currentIndex = 0;
  List<int> listOffsets = [];
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

  }
  void _calculateListOffsets() {
    int offset = 0;
    for (int i = 0; i < bottomMenu.length; i++) {
      listOffsets.add(offset);
      offset += bottomMenu[i].length * 150;
    }
  }
  void _onScroll() {
    final itemHeight = 155; // Replace with the actual height of each item
    final offset = scrollControllerColumn.offset;
    int? currentIndexNew;

    for (int i = 0; i < listOffsets.length; i++) {
      final startOffset = listOffsets[i];
      final endOffset = startOffset + bottomMenu[i].length * itemHeight;

      if (offset >= startOffset && offset < endOffset) {
        currentIndexNew = i;
        break;
      }
    }
    if (currentIndexNew != currentIndex) {
        currentIndex = currentIndexNew!;
      if(currentIndex!=topMenu.length-1&&currentIndex!=topMenu.length-2)
        Timer(Duration(milliseconds: 200), () {
          itemScrollController.jumpTo(index: currentIndex, alignment: 0.3);
        });
    }
    emit(Reload());
  }
  void scrollToIndex(int index) {
    int items=calculateTotalLength(bottomMenu,index);
    scrollController.animateTo(
      items * 170, // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeOut, // Adjust the curve as per your preference
    );
  }
  void addValue(String name, int value) {
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
    emit(Reload());
  }
  void minusValue(String name, int value) {
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
    emit(Reload());
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
    emit(ViewChange());
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
  Categories ?catego;
  void catetory(){
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories',
      token: "y6h6jwH610mVxvdY5Xrenu8e4lULiQ80YzE0MnCjeNGYU4pxumL5fPLUYLjTEYmX1UIIR0",
        myapp: false,
    ).then((value) {
      catego=Categories.fromJson(value.data);
      emit(CategoriesSuccess());
    }).catchError((error) {
      emit(CategoriesError());
    });}
  LoginUser ?loginUser;
  void userLogin({
    required String phoneNumber,
  }){
    emit(LoginLoading());
    DioHelper.postData(url: 'users/generate-otp', data: {
      'phoneNumber' : phoneNumber,
    }).then((value) {
      loginUser= LoginUser.fromJson(value.data);
      print(value.data);
      emit(LoginSuccess());
    }).catchError((error) {
      print(error.toString());
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
    DioHelper.postData(url: 'users/verify-otp', data: {
      'phoneNumber' : phoneNumber,
      'otp':otpNumber
    }).then((value) {
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      getNewUser(context);
      emit(LoginOTPSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginOTPError());
    });
  }
  void changeLanguage(language){
    dropdownvalue = language;
    emit(ChangeLanguageSuccess());
  }

  GetUserData ?getUserData;
  Balance ?balanceData;
  void getNewUser(context){
    emit(GetUserLoading());
    DioHelper.getData(url: 'users/auth/me',
      token: token,
    myapp: true
    ).then((value) {
      getUserData=GetUserData.fromJson(value.data);
      DioHelper.getData(url: 'wallet/${getUserData!.id}/balance',myapp: true).then((newValue) async {
            balanceData=Balance.fromJson(newValue.data);
            balances=await Save.savedata(key: 'balance',value:balanceData!.balance) ;
            emit(GetUserSuccess());
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetUserError());
    });
  }
  void userInvitation(){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'users/generate-invitation-code', token: token, data: {}).then((value) {
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

    if (username != null) {data['username'] = username;}
    if (email != null) {data['email'] = email;}
    if (birthdate != null) {data['birthdate'] = birthdate;}
    DioHelper.patchData(url: 'users/auth/me', token: token,data:data).then((value) {
      DioHelper.getData(url: 'users/auth/me',
          token: token,
          myapp: true
      ).then((value) {
        getUserData=GetUserData.fromJson(value.data);
      });

      print('truuuuuuuuuuu');
      emit(UpdateUserSuccess(getUserData!));
    }).catchError((error) {
      emit(UpdateUserError());
    });
  }

}

