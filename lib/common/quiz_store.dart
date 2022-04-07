import 'package:shared_preferences/shared_preferences.dart';

class QuizStore {
  static SharedPreferences? prefs;

  static Future<void> initPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }
}