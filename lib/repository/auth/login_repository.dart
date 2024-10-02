import 'package:bloc_clean_architecture/config/AppUrl/app_url.dart';
import 'package:bloc_clean_architecture/data/network/network_api_services.dart';
import 'package:bloc_clean_architecture/models/user/user_model.g.dart';
import 'package:http/http.dart';

class LoginRepository {
  final _api = NetworkApiServices(); // come fromNetwork

  Future<UserModel> loginApi(dynamic data) async {
    final response = await _api.postApi(AppUrl.loginApi, data);
    return UserModel.fromJson(response);
  }
}
