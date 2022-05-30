class UserBase {
  late String name;
  late String username;

  UserBase(
    this.name,
    this.username,
  );

  UserBase.fromJson(dynamic json) {
    name = json["name"];
    username = json["username"];
  }
}

class User extends UserBase {
  String password;

  User(name, username, this.password) : super(name, username);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["username"] = username;
    map["password"] = password;
    return map;
  }
}