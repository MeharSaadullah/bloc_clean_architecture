import 'package:bloc_clean_architecture/bloc/bloc/login_bloc.dart';
import 'package:bloc_clean_architecture/bloc/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInputWidgets extends StatelessWidget {
  final FocusNode passwordFocusNode;
  const PasswordInputWidgets({super.key, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) => current.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          focusNode: passwordFocusNode,
          //  controller: emailcontroller,
          decoration: const InputDecoration(
            labelText: 'password',
            hintText: '*****',
            helperText: 'enter password ',
            prefixIcon: Icon(Icons.password),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            return null;
          },
          onFieldSubmitted: (value) {},
        );
      },
    );
  }
}
