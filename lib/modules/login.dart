import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/componants.dart';
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3),
                    blurRadius: 15, spreadRadius: 5),]),
          child: Column(
            children: [
              buildSignupSection(), Spacer(),bottom((){DeliveryCubit.get(context).userLogin(phoneNumber: numberController.text);
              navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
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
          IntlPhoneField(decoration: InputDecoration(labelText: 'Phone number'),
            initialCountryCode: 'SA',
            onCountryChanged: (code){
              countryCode=code.fullCountryCode;
            },
            controller: numberController,)
        ],
      ),
    );
  }
  Widget bottom(onTap){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.indigo, Colors.indigoAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1))
            ]),
        child: Center(child:  Text('Verify Phone number', style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white))),
      ),
    );
  }
  void phoneauth()async{

  }
}
