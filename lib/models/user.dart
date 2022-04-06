import 'package:flutter/cupertino.dart';

class User {
  String email;
  String userName;
  String password;
  int id;

  User({
    this.id,
    this.userName,
    @required this.email,
    @required this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        id = json['id'],
        userName = json['username'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'username': userName,
      };

  Map<String, Object> toMap() {
    var map = <String, Object>{columnId: id, columnEmail: email, columnPassword: password, columnUsername: userName};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User.fromMap(Map<String, Object> map) {
    id = map[columnId];
    email = map[columnEmail];
    userName = map[columnUsername];
    password = map[columnPassword];
  }

  static const String tableUser = 'user';
  static const String columnId = 'id';
  static const String columnEmail = 'email';
  static const String columnUsername = 'username';
  static const String columnPassword = 'password';
}
