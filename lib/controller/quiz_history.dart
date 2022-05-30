import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:withbible_app/controller/api.dart';
import 'package:withbible_app/controller/auth.dart';
import 'package:withbible_app/model/leader_board.dart';
import 'package:withbible_app/model/quiz_history.dart';

Future<List<QuizHistory>> loadQuizHistory() async {
  var user = await AuthControl.getUser();
  String name = user[0];

  var url = Uri.parse('${Api.url}/history?name=$name');
  var response = await http.get(url, headers: Api.headers);
  var jsonResult = json.decode(response.body);

  List<QuizHistory> quizHistoryList = List<QuizHistory>.from(
      jsonResult['data'].map((model) => QuizHistory.jsonToObject(model)));

  return quizHistoryList;
}

Future<QuizHistory?> loadQuizHistoryByTitle(String title) async {
  var user = await AuthControl.getUser();
  String name = user[0];

  var url = Uri.parse('${Api.url}/history?name=$name&title=$title');
  var response = await http.get(url, headers: Api.headers);

  // TODO: Need error object?
  if (response.statusCode == 400) {
    return null;
  }

  var jsonResult = json.decode(response.body);
  return QuizHistory.jsonToObject(jsonResult['data'].first);
}

Future<void> saveQuizHistory(QuizHistory history, {isNew: true}) async {
  var url = Uri.parse('${Api.url}/history');
  String historyJson = jsonEncode(history);

  if (isNew) {
    await http.put(url, headers: Api.headers, body: historyJson);
  } else {
    await http.post(url, headers: Api.headers, body: historyJson);
  }
}

Future<List<LeaderBoard>> loadLeaderBoard() async {
  var url = Uri.parse('${Api.url}/leaderBoard');
  var response = await http.get(url, headers: Api.headers);
  var jsonResult = json.decode(response.body);

  List<LeaderBoard> leaderBoardList = List<LeaderBoard>.from(
    jsonResult['data'].map((model) => LeaderBoard.jsonToObject(model)),
  );

  return leaderBoardList;
}
