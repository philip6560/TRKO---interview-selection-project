

import 'package:flutter/material.dart';
import 'package:trko/database/db_helper.dart';
import 'package:trko/database/models/users.dart';


class DB_screen extends StatefulWidget {
  @override
  _DB_screenState createState() => _DB_screenState();
}

class _DB_screenState extends State<DB_screen> {

  Future<List<User>> users;
  var dbHelper = DBHelper();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    setState(() {
      users = dbHelper.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: users,
          builder: (context, snapshot){
            if (snapshot.hasData){
              return Text('${snapshot.data}');
            }
            if (snapshot.data == null || snapshot.data.length == 0){
              return Text('No Data Found');
            }
          },
        ),
      ),
    );
  }
}
