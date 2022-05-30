import 'package:withbible_app/model/user.dart';

class LeaderBoard extends UserBase {
  String photoPath;
  int totalScore;

  LeaderBoard(
    name,
    username,
    this.photoPath,
    this.totalScore,
  ) : super(name, username);

  static jsonToObject(dynamic json) {
    late UserBase user;

    if (json["user"] != null) {
      user = UserBase.fromJson(json["user"]);
    }
    return LeaderBoard(
      json["name"] = user.name,
      json["username"] = user.username,
      json["photoPath"],
      json["totalScore"],
    );
  }
}
