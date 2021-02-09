

import 'package:flutter/material.dart';
import 'package:trko/screens/contact_screen.dart';
import 'package:trko/screens/home.dart';
import 'package:trko/screens/projects_screen.dart';
import 'package:trko/screens/login_screen.dart';
import 'package:trko/screens/payments_screen.dart';
import 'package:trko/screens/signup_screen.dart';
import 'package:trko/screens/splash_screen.dart';
import 'package:trko/database/db_screen.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Splash(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup(),
      '/projects': (context) => Projects(),
      '/payments': (context) => Payments(),
      '/contact': (context) => Contact(),
      '/home': (context) => Home(),
      '/dbscreen': (context) => DB_screen(),
    },
  ));
}