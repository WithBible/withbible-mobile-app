import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:withbible_app/common/json_util.dart';
import 'package:withbible_app/data/categories.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/model/quiz_history.dart';

class QuizStore {
  static SharedPreferences? prefs;
  static const String quizHistoryListKey = "QuizHistoryListKey";
  final String quizJsonFileName = "/data/quiz.json";

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<Quiz>> loadQuizListByCategoryAsync(int categoryId) async {
    List<Quiz> quizList = [];
    quizList = await JsonUtil.loadFromJsonAsync<Quiz>(
        quizJsonFileName, Quiz.jsonToObject);
    var categoryQuizList =
        quizList.where((element) => element.categoryId == categoryId).toList();
    return categoryQuizList;
  }

  Future<List<QuizHistory>> loadQuizHistoryAsync() async {
    List<QuizHistory> quizHistoryList = [];
    var ifExists = QuizStore.prefs!.containsKey(quizHistoryListKey);
    if (ifExists) {
      var quizHistoryJson = QuizStore.prefs!.getString(quizHistoryListKey);
      if (quizHistoryJson != null) {
        quizHistoryList = await JsonUtil.loadFromJsonStringAsync<QuizHistory>(
            quizHistoryJson, QuizHistory.jsonToObject);
      }

      quizHistoryList = quizHistoryList.reversed.toList();
    }
    return quizHistoryList;
  }

  Future<Category> getCategoryAsync(int categoryId) async {
    List<Category> categoryList = [];
    categoryList = categories;
    return categoryList.where((element) => element.id == categoryId).first;
  }

  Future<void> saveQuizHistory(QuizHistory history) async {
    var historyList = await loadQuizHistoryAsync();
    historyList.add(history);
    var historyJson = jsonEncode(historyList);
    prefs!.setString(quizHistoryListKey, historyJson);
  }
}
