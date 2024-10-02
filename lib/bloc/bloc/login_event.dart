//part of 'login_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvents {
  const EmailChanged({required this.email});

  final String email;
  List<Object?> get props => [email];
}

class EmailUnfocused extends LoginEvents {}

class LoginApi extends LoginEvents {}

class PasswordChanged extends LoginEvents {
  const PasswordChanged({required this.password});
  final String password;
  List<Object?> get props => [password];
}
