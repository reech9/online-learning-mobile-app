import 'dart:convert';
import 'dart:io';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/configs/environment.config.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';

import 'api_exception.dart';

String domain = EnvironmentConfig.url;

String IMAGE_DOMAIN = domain;
String WEB_URL = domain.split("/api")[0];

class API {
  final SharedPreferences localStorage = PreferenceUtils.instance;
  Future getData(String apiUrl) async {
    print("[GET] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(domain + apiUrl), headers: _setHeader());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future getWithToken(apiUrl) async {
    print("[GET] :: " + domain + apiUrl);
    dynamic responseJson;
    var token = localStorage.getString('TOKEN');
    if(token == null ){
      return getData(apiUrl);
    }
    try {
      final response = await http.get(Uri.parse(domain + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'platform': EnvironmentConfig.platform,
      });
      print(domain + apiUrl);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print("RESPOSE ERR :: " + e.toString());
    }
    return responseJson;
  }

  Future<dynamic> refreshToken() async{
    dynamic responseJson;
    var Rtoken = localStorage.getString('REFRESH_TOKEN');
    print("RTOKEN :: "+ Rtoken.toString());
    try {
      final response = await http.post(Uri.parse(domain + CustomerEndpoints.refreshToken), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }, body: jsonEncode({
        "refreshToken": Rtoken.toString(),
      }));
      print("RAAW RES PONSE :: "+ response.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  Future deleteWithToken(apiUrl) async {
    print("[DELETE] :: " + domain + apiUrl);
    dynamic responseJson;
    print(domain + apiUrl);

    print(domain + apiUrl);
    var token = localStorage.getString('TOKEN');
    try {
      final response = await http.delete(Uri.parse(domain + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
        'platform': EnvironmentConfig.platform,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataAsWeb(data, apiUrl) async {
    print("[POST WEB] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(domain + apiUrl), body: data, headers: _setHeaderAsWeb())
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          throw FetchDataException('No Internet Connection');
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


  Future postData(data, apiUrl) async {
    print("[POST] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(domain + apiUrl), body: data, headers: _setHeader())
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          throw FetchDataException('No Internet Connection');
        },
      );
      print("response $response");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future putData(data, apiUrl) async {
    print("[POST] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(domain + apiUrl), body: data, headers: _setHeader())
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          throw FetchDataException('No Internet Connection');
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataFast(data, apiUrl) async {
    print("[POST] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(domain + apiUrl), body: data, headers: _setHeader())
          .timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          throw FetchDataException('No Internet Connection');
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithHeader(data, apiUrl) async {
    print("[POST] :: " + domain + apiUrl);
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(domain + apiUrl),
          body: data, headers: _setHeaders());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithToken(data, apiUrl) async {
    dynamic responseJson;

    print("[POST] :: " + domain + apiUrl);
    if (localStorage.containsKey('TOKEN')) {
      var token = localStorage.getString('TOKEN');
      print(token.toString());
      try {
        final response = await http.post(
          Uri.parse(domain + apiUrl),
          headers: <String, String>{
            // 'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': "Bearer ${token.toString()}",
            'platform': EnvironmentConfig.platform,
          },
          body: data,
        );
        print(response);

        responseJson = returnResponse(response);

        responseJson = returnResponse(response);
        print("RES::"  + responseJson.toString());
        // {status: 422, success: false, msg: Your token has been expired. Refresh your access token., STATUS_CODE: 422}
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }
      return responseJson;
    } else {
      return postData(data, apiUrl);
    }
  }

  Future postDataWithTokenAsWeb(data, apiUrl) async {
    dynamic responseJson;

    print("[POST] :: " + domain + apiUrl);
    if(localStorage.containsKey('TOKEN')){
      var token = localStorage.getString('TOKEN');
      print(token.toString());
      try {
        final response = await http.post(
          Uri.parse(domain + apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': token.toString(),
          },
          body: data,
        );

        responseJson = returnResponse(response);
        // if(responseJson)
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }
      return responseJson;
    }else{
      return postData(data, apiUrl);
    }
  }


  Future putDataWithToken(data, apiUrl) async {
    dynamic responseJson;

    print("[PUT] :: " + domain + apiUrl);
    if (localStorage.containsKey('TOKEN')) {
      var token = localStorage.getString('TOKEN');

      try {
        final response = await http.put(
          Uri.parse(domain + apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': "Bearer ${token.toString()}",
            'platform': EnvironmentConfig.platform,
          },
          body: data,
        );

        responseJson = returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }
      return responseJson;
    } else {
      return putData(data, apiUrl);
    }
  }


  Future patchDataWithToken(data, apiUrl) async {
    dynamic responseJson;

    print("[PATCH] :: " + domain + apiUrl);
    if (localStorage.containsKey('TOKEN')) {
      var token = localStorage.getString('TOKEN');
      print("TOKEN ::" + token.toString());
      try {
        final response = await http.patch(
          Uri.parse(domain + apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization' :"Bearer " +  token.toString(),
            'platform': EnvironmentConfig.platform,
          },
          body: data,
        );

        responseJson = returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet Connection');
      }
      return responseJson;
    } else {
      return putData(data, apiUrl);
    }
  }

  Future postDataWithTokenAndFiles(
      data, apiUrl, List<Map<String, List<String>>> images) async {
    dynamic responseJson;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('TOKEN');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token.toString(),
      'platform': EnvironmentConfig.platform,
    };

    var request = http.MultipartRequest("POST", Uri.parse(domain + apiUrl));

    request.fields.addAll(data);
    print("IMage" + images.toString());
    images.forEach((element) {
      print(element.toString());
      element.values.first.forEach((i) {
        try {
          var _image = File(i);
          print(_image);
          request.files.add(
            http.MultipartFile(
              element.keys.first,
              _image.readAsBytes().asStream(),
              _image.lengthSync(),
              filename: "image.jpg",
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        } catch (e) {
          print('eror' + e.toString());
        }
      });
    });

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future postDataWithTokenAndpickedimage(apiUrl, PickedFile file) async {
    dynamic responseJson;

    var token = localStorage.getString('TOKEN');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token.toString(),
      'platform': EnvironmentConfig.platform,
    };

    var request = http.MultipartRequest("POST", Uri.parse(domain + apiUrl));
    request.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(file.path)).readAsBytes(),
        contentType: MediaType('image', 'jpg'), filename: 'image.jpg'));

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


  Future putDataWithTokenAndpickedimage(apiUrl, PickedFile file) async {
    dynamic responseJson;

    var token = localStorage.getString('TOKEN');

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': "Bearer ${token.toString()}",
      'platform': EnvironmentConfig.platform,
    };

    var request = http.MultipartRequest("PUT", Uri.parse(domain + apiUrl));
    request.files.add(http.MultipartFile.fromBytes(
        'image', await File.fromUri(Uri.parse(file.path)).readAsBytes(),
        contentType: MediaType('image', 'jpg'), filename: 'image.jpg'));

    request.headers.addAll(headers);
    try {
      final response = await request.send();
      responseJson = await http.Response.fromStream(response);
      responseJson = returnResponse(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future deleteDataWithToken(apiUrl) async {
    print("[DELETE] :: " + domain + apiUrl);
    dynamic responseJson;
    var token = localStorage.getString('TOKEN');
    try {
      final response = await http.delete(Uri.parse(domain + apiUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token.toString(),
        'platform': EnvironmentConfig.platform,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  _setHeaders() => {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'platform': EnvironmentConfig.platform,
      };

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'platform': EnvironmentConfig.platform,
      };

  _setHeaderAsWeb() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "platform": "web"
  };


  logout() async {
    localStorage.remove('user');
    localStorage.remove('token');
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    print("STATUS CODE :: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        return responseJson;
      case 301:
      case 302:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        try {
          if (responseJson["errors"] != null || responseJson["msg"] != null) {
            return responseJson;
          } else {
            throw BadRequestException(response.body.toString());
          }
        } catch (e) {
          throw BadRequestException(response.body.toString());
        }

      case 401:
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        if (responseJson["errors"] != null || responseJson["msg"] != null) {
          return responseJson;
        } else {
          throw UnauthorisedException(response.body.toString());
        }
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        print("404 ERR :: " + responseJson.toString());
        if (responseJson["errors"] != null || responseJson["msg"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 406:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["msg"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["msg"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 429:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["msg"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 501:
        dynamic responseJson = jsonDecode(response.body);
        responseJson["STATUS_CODE"] = response.statusCode.toString();
        if (responseJson["msg"] != null || responseJson["success"] != null) {
          return responseJson;
        } else {
          throw BadRequestException(response.body.toString());
        }
      case 500:
      default:
        try {
          dynamic responseJson = jsonDecode(response.body);
          responseJson["STATUS_CODE"] = response.statusCode.toString();
          if (responseJson["msg"] != null || responseJson["success"] != null) {
            return responseJson;
          } else {
            throw BadRequestException(response.body.toString());
          }
        } catch (e) {}
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
