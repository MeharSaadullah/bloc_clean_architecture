import 'dart:async';

import 'package:bloc_clean_architecture/config/routes/routes_name.dart';
import 'package:bloc_clean_architecture/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    //here we add sessioncontroller which we created
    SessionController().getUserFromPrefernce().then((value) {
      if (SessionController().islogin ?? false) {
        Timer(
            const Duration(seconds: 3),
            () => Navigator
                .pushNamedAndRemoveUntil // pushNamedAndRemoveUntil it means when we move to next screen previous will be remove
                (context, RoutesName.homescreen, (route) => false));
      } else {
        Timer(
            const Duration(seconds: 3),
            () => Navigator
                .pushNamedAndRemoveUntil // pushNamedAndRemoveUntil it means when we move to next screen previous will be remove
                (context, RoutesName.loginscreen, (route) => false));
      }
    }).onError((error, stackTrace) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator
              .pushNamedAndRemoveUntil // pushNamedAndRemoveUntil it means when we move to next screen previous will be remove
              (context, RoutesName.loginscreen, (route) => false));
    });
  }
}
