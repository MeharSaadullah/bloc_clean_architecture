import 'package:bloc_clean_architecture/Utiles/validations.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_bloc.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInputWidgets extends StatelessWidget {
  final FocusNode emailFocusNode;
  const EmailInputWidgets({super.key, required this.emailFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          //  controller: emailcontroller,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocusNode,
          decoration: const InputDecoration(
            labelText: 'E-mail',
            hintText: 'mehar@gmail.com',
            helperText: 'enter e-mail ',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),

          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },

          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter e-mail';
            }
            if (!Validations.emailValidator(value)) {
              return "email is not valid";
            }
            return null;
          },
        );
      },
    );
  }
}
