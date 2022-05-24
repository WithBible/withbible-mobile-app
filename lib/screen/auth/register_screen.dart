import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/auth.dart';
import 'package:withbible_app/model/user.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with AuthControl {
  bool visibleLoading = false;
  late SharedPreferences preferences;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    print(inspect(formKey.currentState));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHelper.shadowColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('회원 등록'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                buildTextField(nameController, '성함'),
                buildTextField(usernameController, '아이디'),
                buildPasswordField(passwordController, '비밀번호'),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: const Text('제출'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String textType,
      {secure: false}) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        obscureText: secure,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: ThemeHelper.primaryColor),
          labelText: textType,
          prefixIcon: Icon(
            Icons.account_circle_outlined,
            color: ThemeHelper.primaryColor,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ThemeHelper.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(TextEditingController controller, String textType) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        // validator: validatePassword,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: ThemeHelper.primaryColor),
          labelText: textType,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: ThemeHelper.primaryColor,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ThemeHelper.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
