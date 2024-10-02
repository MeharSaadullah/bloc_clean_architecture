import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_clean_architecture/data/exceptions/app_exceptions.dart';
import 'package:bloc_clean_architecture/data/network/base_appi_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices implements BaseAppiServices {
  @override
  //...................GET Api......................

  Future getApi(String url) async {
    dynamic jsonResponse;
    // // TODO: implement getApi
    // throw UnimplementedError();

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException(
          ""); //here no internet exception come from app_exceptions
    } on TimeoutException {
      FetchDataException("Time out Try Agian");
    }
    return jsonResponse;
  }

  @override
  //......................POST Api..................

  Future postApi(String url, var data) async {
    dynamic jsonResponse;
    // // TODO: implement getApi
    // throw UnimplementedError();

    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException(
          ""); //here no internet exception come from app_exceptions
    } on TimeoutException {
      FetchDataException("Time out Try Agian");
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
        dynamic jsonResponse = jsonDecode(response.body);

        throw UnauthorisedException();
      case 500:
        throw FetchDataException(
            "Error communication with server" + response.statusCode.toString());
    }
  }
}
