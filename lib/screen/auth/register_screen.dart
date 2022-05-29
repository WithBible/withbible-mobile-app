import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/auth.dart';
import 'package:withbible_app/model/user.dart';
import 'package:withbible_app/screen/auth/login_screen.dart';
import 'package:withbible_app/widget/bottom_widget.dart';
import 'package:withbible_app/widget/disco_button.dart';

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
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      visibleLoading = true;
    });
    formKey.currentState!.save();

    Future.delayed(const Duration(milliseconds: 500), () async {
      Map register = await registerUser(User(
        nameController.text,
        usernameController.text,
        passwordController.text,
      ));

      if (register['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${register['message']}'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("가입이 완료되었습니다."),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushReplacementNamed(context, BottomWidget.routeName);
      }

      setState(() {
        visibleLoading = false;
      });
    });
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
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                buildTextField(nameController, '성함'),
                buildTextField(usernameController, '아이디'),
                buildPasswordField(passwordController, '비밀번호'),
                buildButton(),
                buildPageRoute(),
                const SizedBox(height: 10),
                buildFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String textType) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        validator: validateText,
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
        validator: validatePassword,
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

  Widget buildButton() {
    return DiscoButton(
      onPressed: _submit,
      child: !visibleLoading
          ? const Text(
              '등록',
              style: TextStyle(color: Color(0xfffbce7b), fontSize: 16),
              textAlign: TextAlign.center,
            )
          : Visibility(
              visible: visibleLoading,
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.6,
                    color: Color(0xfffbce7b),
                  ),
                ),
              ),
            ),
      width: 100,
      height: 50,
    );
  }

  Widget buildPageRoute() {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('계정이 있으시다면?'),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ),
              child:
                  const Text('로그인', style: TextStyle(color: Color(0xfffbce7b))))
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: const Text('등록을 누르시면 개인정보 수집에 동의하게됩니다.'));
  }
}
