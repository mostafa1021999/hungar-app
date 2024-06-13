import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/otp%20number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String countryCode='966';
  var formKey=GlobalKey<FormState>();
  TextEditingController numberController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      body: Center(
        child: Container(
          height:220,
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: isdark??false? Colors.black12:Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1),
                    blurRadius: 20, spreadRadius: 5),]),
          child: Column(
            children: [
              buildSignupSection(), Spacer(),bottom(dropdownvalue=='English Language'?'Continue':'متابعه',(){DeliveryCubit.get(context).userLogin(phoneNumber: '${countryCode+numberController.text}');
              if(numberController.text.isNotEmpty)
              {
                if(numberController.text.startsWith('5')&&numberController.text.length==9){
                  navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(dropdownvalue=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white) ,)),backgroundColor: Colors.red.shade300,),);
                }
              }
              })
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          IntlPhoneField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 16),
              labelText:dropdownvalue=='English Language'? 'Phone number':"رقم الهاتف",),
            initialCountryCode: 'SA',
            onCountryChanged: (code){
              countryCode=code.fullCountryCode;
            },
            validator: (value){return dropdownvalue=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح";},
            invalidNumberMessage:dropdownvalue=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح",
            controller: numberController,)
        ],
      ),
    );
  }
}

