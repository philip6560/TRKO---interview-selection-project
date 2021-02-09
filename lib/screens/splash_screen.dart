import 'package:flutter/material.dart';
import 'package:trko/utils/UI responsiveness.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  loading() async{
    await Future.delayed(Duration(seconds: 3));

    return Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(18.0, 247.0, 17.0, 246.0),
          height: scale_height(46.315, context),
          width: scale_width(91.505, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/trko_logo.png'),
                fit: BoxFit.cover,
              )
          ),
        ),
      ),
    );
  }
}
