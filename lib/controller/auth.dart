import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:withbible_app/controller/api.dart';
import 'package:withbible_app/model/user.dart';

class AuthControl {
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

  Future<bool> registerUser(User user) async {
    var url = Uri.parse('${Api.url}/user/register');
    String registerJson = jsonEncode(user);

    var response =
        await http.post(url, headers: Api.headers, body: registerJson);

    if (response.statusCode == 201) {
      return true;
    }
    // TODO: 에러 객체
    return false;
  }

  Future<bool> loginUser(String username, String password) async {
    var url = Uri.parse('${Api.url}/user/login');
    String loginJson = jsonEncode({"username": username, "password": password});

    var response = await http.patch(url, headers: Api.headers, body: loginJson);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
