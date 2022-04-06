import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/utils/constant.dart';
import 'package:sqflite/sqflite.dart';

class DBLite {
  static final DBLite _singleton = DBLite._internal();

  DBLite._internal();

  static DBLite get i => _singleton;

  static Database _db;

  void initialize() async {
    _db = await openDatabase(SqlLite.path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
      create table ${User.tableUser} ( 
      ${User.columnId} integer primary key autoincrement, 
      ${User.columnEmail} text not null,
      ${User.columnUsername} text,
      ${User.columnPassword} text not null)
      ''');
    });

    if (_db != null) {
      await _db.insert(User.tableUser, {
        '${User.columnPassword}': "123456",
        '${User.columnEmail}': "majoo@gmail.com",
      });
    }
  }


  Future<User> insert(User user) async {
    try {
      user.id = await _db.insert(User.tableUser, user.toMap());
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User> getUser({@required String email, @required String password}) async {
    try {
      List<Map> maps = await _db.query(
        User.tableUser,
        columns: [User.columnId, User.columnPassword, User.columnEmail],
        where: '${User.columnPassword} = $password and ${User.columnEmail} = "$email"',
      );

      if (maps.isNotEmpty) return User.fromMap(maps.first);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
