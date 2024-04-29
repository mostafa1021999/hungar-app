import 'package:delivery/modules/login.dart';
import 'package:delivery/modules/onBoarding.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>  onBoarding());
      case '/firstpage':
        return MaterialPageRoute(
            builder: (_) => Login());
      case '/secondpage':
        return MaterialPageRoute(
            builder: (_) => Login());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}