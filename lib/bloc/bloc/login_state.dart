part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = " ",
      this.password = "",
      this.postApiStatus = PostApiStatus.initial,
      this.message = " "});
  final String email;
  final String password;
  final PostApiStatus postApiStatus; // this come form enum inside UTILES
  final String message;

  LoginState copyWith(
      {String? email,
      String? password,
      PostApiStatus? postApiStatus,
      String? message}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, postApiStatus, message];
}
