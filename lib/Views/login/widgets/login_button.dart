import 'package:another_flushbar/flushbar_helper.dart';
import 'package:bloc_clean_architecture/Utiles/enumes.dart';
import 'package:bloc_clean_architecture/Utiles/flushbar_helper.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_bloc.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_event.dart';
import 'package:bloc_clean_architecture/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  final formKey;
  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          context.flushBarErrorMessage(message: "No User Found"
              //state.message.toString(),
              );
        }

        if (state.postApiStatus == PostApiStatus.success) {
          // Show Flushbar first
          context.flushBarSuccessMessage(
            message: "Login successful",
          );

          // Delay navigation to let the Flushbar display
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamed(context, RoutesName.homescreen);
          });
        }

        // TODO: implement listener
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (current, previous) =>
            current.postApiStatus != previous.postApiStatus,
        //  buildWhen: (current, previous) => false,
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginApi());
                  if (state.password.length < 6) {
                    print("enter password greater then 6 char");
                  }
                }
              },
              child: state.postApiStatus == PostApiStatus.loadaing
                  ? CircularProgressIndicator()
                  : const Text("Log in"));
        },
      ),
    );
  }
}
