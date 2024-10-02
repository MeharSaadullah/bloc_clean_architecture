import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/Utiles/enumes.dart';
import 'package:bloc_clean_architecture/main.dart';
import 'package:bloc_clean_architecture/repository/auth/login_repository.dart';
import 'package:bloc_clean_architecture/services/session_manager/session_controller.dart';
import 'package:equatable/equatable.dart';

import 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginRepository loginRepository = LoginRepository(); // creating instance
  LoginBloc() : super(const LoginState()) {
    // on<LoginEvents>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }
  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    Map data = {"email": state.email, "password": state.password};
    // Map data = {"email": "eve.holt@reqres.in", "password": "cityslicka"};

    emit(state.copyWith(postApiStatus: PostApiStatus.loadaing));
    await loginRepository.loginApi(data).then((value) async {
      if (value.token != null && value.token!.isNotEmpty) {
        // here we add sessioncontroler to add the data of usser
        await SessionController().saveUserInPreference(value);
        await SessionController().getUserFromPrefernce();

        // If there is no error, it's a successful login
        emit(state.copyWith(
            message: "Login Successful", postApiStatus: PostApiStatus.success));
      } else {
        // If there is an error, emit the error message
        emit(state.copyWith(
            message: value.error.toString(),
            postApiStatus: PostApiStatus.error));
      }
    }).onError((error, stackTrace) {
      // Handling any error that occurs during the API call
      emit(state.copyWith(
          message: error.toString(), postApiStatus: PostApiStatus.error));
    });
  }
}
