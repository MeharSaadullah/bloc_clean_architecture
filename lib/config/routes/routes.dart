import 'package:bloc_clean_architecture/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../Views/view.dart'; // here we import that view.dart

class Routes {
  // here we write static function which returnd  dynamic value
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // here we add conditions
    // routesname come from routename class
    switch (settings.name) {
      case RoutesName.splashscreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.loginscreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.homescreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(child: Text(" No Routes Found")),
          );
        });
    }
  }
}
