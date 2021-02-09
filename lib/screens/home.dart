import 'package:flutter/material.dart';
import 'package:trko/screens/projects_screen.dart';
import 'package:trko/screens/payments_screen.dart';
import 'package:trko/screens/contact_screen.dart';
import 'package:trko/utils/UI%20responsiveness.dart';
import 'package:trko/utils/theme.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  List<Widget> _children = [
    Projects(),
    Payments(),
    Contact(),
  ];

  void _selected(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(style: BorderStyle.solid, width: 1.1, )),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: MyCustomColors.blue(),
          selectedFontSize: scale_height(1.597, context),
          unselectedFontSize: scale_height(1.474, context),
          iconSize: scale_height(2.948, context),
          onTap: _selected,
          currentIndex: _currentIndex,
          items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.credit_card_rounded), label: 'Payments'),
              BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label: 'Contact Us'),
        ],
        ),
      ),
    );
  }
}
