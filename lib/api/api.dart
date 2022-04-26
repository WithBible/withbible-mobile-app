import 'dart:convert';

import 'package:withbible_app/model/quiz.dart';
import 'package:http/http.dart' as http;
import 'package:withbible_app/model/quiz_history.dart';
import 'package:withbible_app/store/quiz_store.dart';

class Api {
  final String _url = "http://127.0.0.1:5000";

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json"
  };

  Future<List<Quiz>> loadQuizListByCategoryAsync(int categoryId) async {
    var url = Uri.parse('$_url/quiz/category/$categoryId');
    var response = await http.get(url, headers: headers);
    var jsonResult = json.decode(response.body);

    List<Quiz> quizList = List<Quiz>.from(
        jsonResult['data'].map((model) => Quiz.jsonToObject(model)));

    return quizList;
  }

  Future<Quiz> getQuizByTitleAsync(String quizTitle, int categoryId) async {
    var quizList = await loadQuizListByCategoryAsync(categoryId);
    var quiz = quizList.where((element) => element.title == quizTitle).first;
    return quiz;
  }

  Future<List<QuizHistory>> loadQuizHistoryAsync() async {
    String name = await QuizStore.getName('name');
    var url = Uri.parse('$_url/history?name=$name');
    var response = await http.get(url, headers: headers);
    var jsonResult = json.decode(response.body);

    List<QuizHistory> quizHistoryList = List<QuizHistory>.from(
        jsonResult['data'].map((model) => QuizHistory.jsonToObject(model)));

    return quizHistoryList;
  }

  Future<void> saveQuizHistory(QuizHistory history) async {
    var url = Uri.parse('$_url/history');
    String historyJson = jsonEncode(history);

    var response = await http.put(url, headers: headers, body: historyJson);
    var result = json.decode(response.body);
    print('RESULT: ${result}');
  }
}
