import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/home.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpNumber extends StatefulWidget {
  String phoneNumber;
  String country;
  OtpNumber({super.key,required this.phoneNumber,required this.country});
  @override
  State<OtpNumber> createState() => _OtpNumberState(phoneNumber: phoneNumber, country: country);
}

class _OtpNumberState extends State<OtpNumber> {
  String phoneNumber;
  String country;
  _OtpNumberState({required this.phoneNumber,required this.country});
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    if(state is LoginOTPSuccess){
      token=DeliveryCubit.get(context).loginOTP!.token;
      Save.savedata(key: 'token', value: token).then((value){
        navigateAndFinish(context,  Home(isdark));
      });}
  },
  builder: (context, state) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text(
                  "Enter the code sent to your number",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  '+'+country+' '+phoneNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
                validator: (value) {
                  DeliveryCubit.get(context).userLoginOTP(phoneNumber: phoneNumber,otpNumber: value??'');
                  return state is LoginOTPSuccess  ? navigate(context,  Home(isdark)) : 'Code is not match';
                },
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}