import 'package:bloc_clean_architecture/Views/login/widgets/password_input_widgets.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc; // here we adding Bloc
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
  }

  final _formKey = GlobalKey<FormState>(); // for validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EmailInputWidgets(emailFocusNode: emailFocusNode),
              const SizedBox(
                height: 20,
              ),
              PasswordInputWidgets(passwordFocusNode: passwordFocusNode),
              const SizedBox(
                height: 50,
              ),
              LoginButton(formKey: _formKey)
            ],
          )),
    ));
  }
}
