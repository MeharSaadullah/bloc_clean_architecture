import 'package:bloc_clean_architecture/config/components/Internet_exception.dart';
import 'package:bloc_clean_architecture/config/components/loading_widget.dart';
import 'package:bloc_clean_architecture/config/components/round_button.dart';
import 'package:bloc_clean_architecture/config/routes/routes_name.dart';
import 'package:bloc_clean_architecture/services/splash/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices _splashServices =
      SplashServices(); // here we are adding intilizing splash_services
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashServices.islogin(context); // here we add islogin function which we created in splash_screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(" Splash Screen",style: TextStyle(fontSize: 50),) );
  }
}
