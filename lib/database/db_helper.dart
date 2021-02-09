import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trko/database/models/users.dart';


class DBHelper {

  static Database _db;
  static const String ID = 'id';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';
  static const String TABLE = 'Users';
  static const String DB_NAME = 'users.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTGER, $EMAIL TEXT PRIMARY KEY, $PASSWORD TEXT)");
  }

  Future<User> save(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert(TABLE, user.toMap());
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
        TABLE, columns: [ID, EMAIL, PASSWORD]);

    List<User> users = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i]));
      }
      var emails = users.map((e) => e.email).toList();
      print('$maps');
    }
    return users;
  }

  Future<dynamic> getUser(String email, String password) async {
    var dbClient = await db;
    String match = 'proceed';
    String partialMatch = 'Incorrect password. Try again.';
    String noMatch = 'Invalid Credentials. New Member? click register';
    var password_verification = await dbClient.query(TABLE, columns: [PASSWORD],
      where: "$EMAIL = ?",
      whereArgs: [email],);


    if(password_verification.length == 1){
      for(Map i in password_verification){
        String check = i.values.toString();
        if(check.substring(1, (check.length)- 1) == password){
          return match;
        }else{
          return partialMatch;
        }
      }
    }
    else{
      return noMatch;
    }
  }

    Future<int> deleteUser(int id) async {
      var dbClient = await db;
      return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
    }

    Future<int> updateUser(User user) async {
      var dbClient = await db;
      return await dbClient.update(
          TABLE, user.toMap(), where: '$ID = ?', whereArgs: [user.id]);
    }

    Future close() async {
      var dbClient = await db;
      dbClient.close();
    }
  }
