import 'package:withbible_app/model/question.dart';

class Quiz {
  late int id;
  late int categoryId;
  late String title;
  late bool shuffleQuestions;
  late List<Question> questions;

  Quiz(this.id, this.categoryId, this.title, this.shuffleQuestions,
      this.questions);

  static jsonToObject(dynamic json) {
    List<Question> questionList = [];
    if (json["questions"] != null) {
      questionList = List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x)));
    }
    return Quiz(json["id"], json["categoryId"], json["title"],
        json["shuffleQuestions"], questionList);
  }
}
