import 'package:bloc/bloc.dart';
import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/models/Categories%20model.dart';
import 'package:delivery/models/login%20model.dart';
import 'package:delivery/models/offers model.dart';
import 'package:delivery/models/otpModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial());
  int current = 3;
  int advertising = 0;
  bool changeViewNew=false;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  static DeliveryCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> bottomen = [
    const BottomNavigationBarItem(icon:  Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.apps_outlined),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
      label: 'Chart',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),
      label: 'settings',

    ),
  ];
  void increment(){
    emit(Reload());
  }
  List<BluredNavBarXItem> bottomar = [
     BluredNavBarXItem(icon: Icons.settings,
       title: 'الاعدادت',
    ),
     BluredNavBarXItem(icon: Icons.shopping_cart,
       title: 'السله',
    ),
     BluredNavBarXItem(icon: Icons.apps_outlined,
       title: 'الطلبات',
    ),
     BluredNavBarXItem(icon:  Icons.home,
      title: 'الرئيسيه',
    ),
  ];
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

  Categories ?catego;
  void catetory(){
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories',
      token: "y6h6jwH610mVxvdY5Xrenu8e4lULiQ80YzE0MnCjeNGYU4pxumL5fPLUYLjTEYmX1UIIR0",
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
  }){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'users/verify-otp', data: {
      'phoneNumber' : phoneNumber,
      'otp':otpNumber
    }).then((value) {
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
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
}
