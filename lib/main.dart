import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/login.dart';
import 'package:delivery/modules/onBoarding.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_actions/quick_actions.dart';
import 'Cubite/app_dark_light_cubit.dart';
import 'Cubite/delivery_cubit.dart';
import 'componants/colors.dart';
import 'componants/constant values.dart';
import 'componants/constant values.dart';
import 'modules/home.dart';
import 'modules/otp number.dart';
import 'modules/restaurant page.dart';
import 'modules/routs of app icon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Save.init();
  bool? onboard = Save.getdata(key: 'save');
  token = Save.getdata(key: 'token');
  Widget widget;
  if (onboard != null) {
    widget = Home(isdark);
  } else {
    widget = const onBoarding();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  const MyApp(this.start, {Key? key}) : super(key: key);
  final Widget start;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeliveryCubit>(
          create: (context) => DeliveryCubit()..offers()..catetory(),
        ),
        BlocProvider<AppDarkLightCubit>(
          create: (context) => AppDarkLightCubit(),
        ),
      ],
      child: BlocBuilder<AppDarkLightCubit, AppDarkLightState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'fontTop',
              primarySwatch: mainColor,
            ),
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              fontFamily: 'fontTop',
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.transparent,
              ),      textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
              primaryColor: Colors.grey,
              brightness: Brightness.dark,
              hintColor: Colors.white,
              dividerColor: Colors.black12,
              appBarTheme: const AppBarTheme(
                color: Colors.black54,
              ),),
            themeMode: isdark??false ? ThemeMode.dark : ThemeMode.light,
            home: start,
          );
        },
      ),
    );
  }
}