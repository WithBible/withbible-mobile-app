import 'dart:convert';

import 'package:withbible_app/model/quiz.dart';
import 'package:http/http.dart' as http;

class Api{
  final String _url = "http://127.0.0.1:5000";

  Map<String, String> headers = {
   "Access-Control-Allow-Origin": "*"
  };

  Future<List<Quiz>> loadQuizListByCategoryAsync(int categoryId) async {
    var url = Uri.parse('$_url/quiz/category/$categoryId');
    var response = await http.get(url, headers: headers);
    var jsonResult = json.decode(response.body);

    List<Quiz> quizList =
      List<Quiz>.from(jsonResult['data'].map((model) => Quiz.jsonToObject(model)));

    return quizList;
  }
}