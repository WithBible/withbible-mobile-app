import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:withbible_app/controller/api.dart';
import 'package:withbible_app/model/user.dart';

class AuthControl {
  var response;
  Map<String, dynamic> result = {};

  String? validateText(value) {
    if (value!.isEmpty) {
      return '텍스트를 기입해주세요.';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 6) {
      return '비밀번호가 너무 짧습니다.';
    }
    return null;
  }

  Future<Map> registerUser(User user) async {
    var url = Uri.parse('${Api.url}/user/register');
    String registerJson = jsonEncode(user);

    try {
      response = await http.post(url, headers: Api.headers, body: registerJson);
    } catch (error) {
      return result = {'status': false, 'message': error};
    }

    if (response.statusCode == 201) {
      return result = {'status': true};
    }

    var jsonResult = json.decode(response.body);
    return result = {'status': false, 'message': jsonResult['message']};
  }

  Future<Map> loginUser(String username, String password) async {
    var url = Uri.parse('${Api.url}/user/login');
    String loginJson = jsonEncode({"username": username, "password": password});

    try {
      response = await http.patch(url, headers: Api.headers, body: loginJson);
    } catch (error) {
      return result = {'status': false, 'message': error};
    }

    var jsonResult = json.decode(response.body);
    if (response.statusCode == 200) {
      return result = {'status': true, 'data': jsonResult["data"]};
    }

    return result = {'status': false, 'message': jsonResult['message']};
  }

  setUser(UserBase userBase) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setStringList('user', [userBase.name, userBase.username]);
  }

  static getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('user');
  }
}
