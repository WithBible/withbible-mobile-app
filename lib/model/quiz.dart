import 'package:withbible_app/model/question.dart';

class Quiz {
  late String categoryId;
  late String title;
  late bool shuffleQuestions;
  late List<Question> questions;

  Quiz(this.title, this.shuffleQuestions, this.categoryId, this.questions);

  static jsonToObject(dynamic json) {
    List<Question> questionList = [];
    if (json["questions"] != null) {
      questionList = List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x)));
    }
    return Quiz(json["categoryId"], json["title"], json["shuffleQuestions"],
        questionList);
  }
}
