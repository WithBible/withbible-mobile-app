class Option {
  late String code;
  late String text;
  late bool isCorrect;

  Option(this.code, this.text, this.isCorrect);

  Option.fromJson(dynamic json) {
    code = json["code"];
    text = json["text"];
    isCorrect = json["isCorrect"];
  }
}
