import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:withbible_app/controller/api.dart';
import 'package:withbible_app/model/category.dart';
import 'package:withbible_app/model/quiz.dart';
import 'package:withbible_app/data/categories.dart';

Future<List<Quiz>> loadQuizListByCategory(int categoryId) async {
  var url = Uri.parse('${Api.url}/quiz/category/$categoryId');
  var response = await http.get(url, headers: Api.headers);
  var jsonResult = json.decode(response.body);

  List<Quiz> quizList = List<Quiz>.from(
      jsonResult['data'].map((model) => Quiz.jsonToObject(model)));

  return quizList;
}

Future<Quiz> getQuizByTitle(String quizTitle, int categoryId) async {
  var quizList = await loadQuizListByCategory(categoryId);
  var quiz = quizList.where((element) => element.title == quizTitle).first;
  return quiz;
}

Future<Category> getCategoryLocalAsync(int categoryId) async {
  List<Category> categoryList = categories;
  return categoryList.where((element) => element.id == categoryId).first;
}
