import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/componants/constant%20values.dart';
import 'package:delivery/modules/onBoarding.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubite/app_dark_light_cubit.dart';
import 'Cubite/delivery_cubit.dart';
import 'modules/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Save.init();

  bool? onboard = Save.getdata(key: 'save');
  token = Save.getdata(key: 'token');
  print(token);
  Widget widget;
  if (onboard != null) {
    widget = const Home();
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
          create: (context) => DeliveryCubit()..getNewUser(context)..offers()..catetory(),
        ),
        BlocProvider<AppDarkLightCubit>(
          create: (context) => AppDarkLightCubit(),
        ),
      ],
      child: BlocBuilder<AppDarkLightCubit, AppDarkLightState>(
        builder: (context, state) {
          return MaterialApp(
            theme: lightMode,
            debugShowCheckedModeBanner: false,
            darkTheme: darkMode,
            themeMode: isdark??false ? ThemeMode.dark : ThemeMode.light,
            home: start,
          );
        },
      ),
    );
  }
}