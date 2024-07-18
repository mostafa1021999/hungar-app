import 'dart:async';

import 'package:delivery/componants/colors.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
     int _index = 4;
    return Directionality(
      textDirection: dropdownvalue=='English Language'?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text('${data[_index]}'),),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberStepper(
              totalSteps: 4,
              height: MediaQuery.of(context).size.height * 0.4,
              curStep: _index,
              stepCompleteColor: mainColor.shade400,
              currentStepColor: mainColor.shade100,
              inactiveColor: Color(0xffbababa), lineHeight: 3,
            ),
          ],
        )
      ),
    );
  }
}

class NumberStepper extends StatefulWidget {
  const NumberStepper({super.key,    required this.height,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineHeight,});
  final double height;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineHeight;
  @override
  State<NumberStepper> createState() => _NumberStepperState(height: height,
    curStep: curStep,
    stepCompleteColor: stepCompleteColor, totalSteps: totalSteps,
    inactiveColor: inactiveColor,
    currentStepColor: currentStepColor,
    lineHeight: lineHeight,);
}

class _NumberStepperState extends State<NumberStepper> with TickerProviderStateMixin{
  final double height;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineHeight;
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  Timer? _animationTimer;
  _NumberStepperState({
    required this.height,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineHeight,
  });
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );


    _animationController
      ..duration = Duration(milliseconds: 1000)
      ..repeat(reverse: true);
    _animationController.addListener(() {
      setState(() {});
    });
    _startAnimation();
  }
  void _startAnimation() {
    _sizeAnimation = Tween<double>(begin: 28.0, end: 32.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: Colors.grey, end: mainColor.shade400).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _animationTimer = Timer(Duration(milliseconds: 1000), () {
      _changeAnimation();
    });
  }
  void _changeAnimation() {
    _sizeAnimation = Tween<double>(begin: 32.0, end: 28.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: mainColor.shade400, end:Colors.grey ).animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _animationTimer = Timer(Duration(milliseconds: 1000), () {
      _startAnimation();
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: dropdownvalue=='English Language'?Alignment.bottomLeft:Alignment.bottomRight,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 24.0,
            ),
            height: this.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _steps(),
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.0,
                      height: 28.0,
                      child: getInnerElementOfStepper(i),
                      decoration: new BoxDecoration(
                        color: circleColor,
                        borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                        border: new Border.all(
                          color: borderColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                  if (i != totalSteps - 1)
                  Container(
                    height: 45,
                    width: lineHeight,
                    color: lineColor,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text('${data[i]}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
            ),
          ],
        ),
      );
      //line between step circles
    }
    return list;
  }
  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      _animationController.forward();
      return _colorAnimation.value;
    } else {
      color = Colors.white;
    }
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      return _colorAnimation.value;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == curStep) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: _sizeAnimation.value,
        height: _sizeAnimation.value,
        child: Center(
          child: Text(
            '$curStep',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }}

  getLineColor(i) {
    var color =
    curStep > i + 1 ? mainColor.withOpacity(0.4) : Colors.grey[200];
    return color;
  }
}
List data=['تم ارسال الطلب للمطعم','تمت الموافقه عليه و المندوب تحرك للمطعم','المندوب فى انتظار الطلب','المندوب فى الطريق اليك','قيم المطعم و المندوب'];