import 'package:withbible_app/model/option.dart';

class Question {
  late String text;
  late List<Option> options;
  Option? selectedOption;

  Question(
    this.text,
    this.options,
  );

  Question.fromJson(dynamic json) {
    text = json["text"];
    options = List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
  }
}