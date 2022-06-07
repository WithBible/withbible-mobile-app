class QuizHistory {
  late String name;
  late int categoryId;
  late String title;
  late List<String> answerSheet;
  late String score;
  late String timeTaken;
  late String date;
  late String status;

  QuizHistory(
    this.name,
    this.categoryId,
    this.title,
    this.answerSheet,
    this.score,
    this.timeTaken,
    this.date,
    this.status,
  );

  static jsonToObject(dynamic json) {
    List<String> answerSheetList = [];
    answerSheetList =
        List<String>.from(json["answerSheet"].map((x) => x.toString()));

    return QuizHistory(
      json["name"],
      json["categoryId"],
      json["title"],
      answerSheetList,
      json["score"],
      json["timeTaken"],
      json["date"],
      json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["categoryId"] = categoryId;
    map["title"] = title;
    map["answerSheet"] = answerSheet;
    map["score"] = score;
    map["timeTaken"] = timeTaken;
    map["date"] = date;
    map["status"] = status;
    return map;
  }
}
