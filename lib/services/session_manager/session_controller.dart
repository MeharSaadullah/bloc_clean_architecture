import 'dart:convert';

import 'package:bloc_clean_architecture/models/user/user_model.g.dart';
import 'package:bloc_clean_architecture/services/storage/local_storage.dart';

class SessionController {
  static final SessionController _session = SessionController
      ._internal(); // its final we can not change the instance of this class

  final LocalStorage localStorage =
      LocalStorage(); // here we add local storage which we have created
  UserModel user = UserModel(); // here we add user modal

  bool? islogin; // to check user is already login or not

  SessionController._internal() {
    islogin = false; // by default here we do it false
  }

  // factory constructer is a special  constructer that return  existance instance
  factory SessionController() {
    return _session;
  }

  // ................store the data.............

  // here we take user modal then we store in localstorage
  // then pass token in setvalue which is created in loacl storage in the key "token"
  Future<void> saveUserInPreference(dynamic user) async {
    localStorage.setValue("token", jsonEncode(user));
    //storing value to check login
    localStorage.setValue('isloign', 'true');
  }

  //............get the data....................

  Future<void> getUserFromPrefernce() async {
    var userData = await localStorage.readValue("token");
    var islogin = await localStorage.readValue('isLogin');

    if (userData.isNotEmpty) {
      SessionController().user =
          // here the from the model is decode and stored in the user
          UserModel.fromJson(jsonDecode(userData));
    }
    // if user is empty it set as false
    SessionController().islogin = islogin == 'true' ? true : false;
  }
  // catch (e) {
  //   debugPrint(e.toString());
  // }
}
