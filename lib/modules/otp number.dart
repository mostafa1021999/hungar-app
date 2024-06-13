import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/componants/componants.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/home.dart';
import 'package:delivery/modules/payment.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpNumber extends StatefulWidget {
  String phoneNumber;
  String country;
  OtpNumber({super.key,required this.phoneNumber,required this.country});
  @override
  State<OtpNumber> createState() => _OtpNumberState(phoneNumber: phoneNumber, country: country);
}

class _OtpNumberState extends State<OtpNumber>  with SingleTickerProviderStateMixin{
  String phoneNumber;
  String country;
  AnimationController? _animationController;
  int levelClock = 2 * 60;
  final FocusNode _pinFocusNode = FocusNode();

  _OtpNumberState({required this.phoneNumber,required this.country});
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    _listenSmsCode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }
  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }
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
      DeliveryCubit.get(context).changeNavigator(3);
      Save.savedata(key: 'token', value: token).then((value){
        loginFromCart? navigate(context, const Payment()): navigateAndFinish(context,const Home());
      });
    }
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
               Text(
                dropdownvalue=='English Language'?"Verification":"تحقق من رقمك",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child:  Text(
                  dropdownvalue=='English Language'?"Enter the code sent to your number":'ادخل الكود المرسل لهاتفك',
                  style: TextStyle(
                    color: isdark??false? Colors.white:Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  '+'+country+' '+'*******'+phoneNumber[7]+phoneNumber[8],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Pinput(
                focusNode: _pinFocusNode,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
                validator: (value) {
                  DeliveryCubit.get(context).userLoginOTP(phoneNumber: '${country+phoneNumber}',otpNumber: value??'',context: context);
                  return value!=DeliveryCubit.get(context).otp? 'Code is not match':null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Resend code after: "),
                  Countdown(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_animationController!),
                  ),
                ],
              ),
              if (state is LoginOTPLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}