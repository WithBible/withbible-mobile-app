class User {
  String name;
  String username;
  String password;

  User(this.name, this.username, this.password);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["username"] = username;
    map["password"] = password;
    return map;
  }
}