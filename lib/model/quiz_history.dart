class QuizHistory {
  int quizId = 0;
  int categoryId = 0;
  String title = "";
  String score = "";
  String timeTaken = "";
  String date = "";
  String status = "";

  QuizHistory(this.quizId, this.categoryId, this.title, this.score, this.timeTaken,
      this.date, this.status);

  static jsonToObject(dynamic json) {
    return QuizHistory(
      json["quizId"],
      json["categoryId"],
      json["title"],
      json["score"],
      json["timeTaken"],
      json["date"],
      json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["quizId"] = quizId;
    map["categoryId"] = categoryId;
    map["title"] = title;
    map["score"] = score;
    map["timeTaken"] = timeTaken;
    map["date"] = date;
    map["status"] = status;
    return map;
  }
}
