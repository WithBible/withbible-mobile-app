class LeaderBoard {
  String name;
  String username;
  String photoPath;
  String score;

  LeaderBoard(this.name, this.username, this.photoPath, this.score);

  static jsonToObject(dynamic json) {
    return LeaderBoard(
      json["name"],
      json["username"],
      json["photoPath"],
      json["score"],
    );
  }
}
