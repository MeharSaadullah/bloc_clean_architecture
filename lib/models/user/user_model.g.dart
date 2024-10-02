class UserModel {
  String? email;
  String? password;
  String? token;
  String? error;

  UserModel({this.email, this.password, this.token, this.error});

  // Deserialize JSON (Response from the API)
  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  // Serialize JSON (Data to be sent in the POST request)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'error': error,
    };
  }
}
