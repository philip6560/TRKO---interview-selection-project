
import 'package:trko/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:trko/utils/UI responsiveness.dart';
import 'package:trko/utils/theme.dart';
import 'package:trko/database/models/users.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _textKey01 = GlobalKey<FormState>();
  final _ftextkey02 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey= GlobalKey<ScaffoldState>();
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  bool _hidePasswordState = true;
  IconData _lockPasswordIcon = MyCustomIcons.eye_slash_regular;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var dbHelper = DBHelper();
  var email;
  var password;
  String match = 'proceed';



  void enable(){
  setState(() {
    _hidePasswordState = true;
    _lockPasswordIcon = MyCustomIcons.eye_slash_regular;
  });
  }

  void disable(){
    setState(() {
      _hidePasswordState = false;
      _lockPasswordIcon = Icons.remove_red_eye_outlined;
    });
  }

  validate() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      User user = User(id: null, email: email, password: password);
      var check_user = await dbHelper.getUser(user.email, user.password);

      if(check_user.toString() == match){
        loading();
        await Future.delayed(Duration(seconds: 6));
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        return _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('$check_user', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
            duration: Duration(seconds: 4), backgroundColor: MyCustomColors.blue()));
      }
    }
  }

  loading(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Container(
        alignment: Alignment.center,
          height: scale_height(14.742, context),
          width: scale_width(29.126, context),
        child: AlertDialog(
          content: Builder(
            builder: (context)=>Container(
              alignment: Alignment.center,
              height: scale_height(12.285, context),
              width: scale_width(24.272, context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/trko_logo.png'),
                    fit: BoxFit.cover,
                  )
              ),
              child: Container(
                margin: EdgeInsets.only(top: scale_height(0.614, context)),
                alignment: Alignment.bottomCenter,
                  child: Text('Please wait...', style: TextStyle(fontSize: scale_height(1.72, context)),)),
          ),
        ),
      )
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(scale_width(22.573, context), scale_height(11.917, context), scale_width(22.572, context), 0.0),
                  // 814 is the actual height
                  height: scale_height(27.641, context),
                  width: scale_width(54.854, context),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/trko_logo.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: scale_width(9.223, context), right: scale_width(8.981, context)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: scale_width(91.505, context),
                        margin: EdgeInsets.only(bottom: scale_height(8.477, context)),
                        child: TextFormField(
                          key: _textKey01,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          focusNode: _emailFocusNode,
                          controller: emailcontroller,
                          validator: (val)=> EmailValidator.validate(val)? null: 'Invalid email address',
                          onSaved: (val)=> email = val,
                          onTap: (){
                            setState(() {
                              _passwordFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          onFieldSubmitted: (_){
                            setState(() {
                              _emailFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          cursorColor: MyCustomColors.blue(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: scale_height(2.089, context),),
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context)),
                            prefixIcon: _emailFocusNode.hasFocus? Icon(Icons.email_outlined, color: MyCustomColors.blue()) : Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyCustomColors.blue())),
                          ),
                        ),
                      ),
                      Container(
                        width: scale_width(91.505, context),
                        margin: EdgeInsets.only(bottom: scale_height(4.668, context)),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: _passwordFocusNode,
                          controller: passwordcontroller,
                          validator: (val)=> val.isEmpty? 'Enter Password': null,
                          onSaved: (val)=> password = val,
                          onTap: (){
                            setState(() {
                              _emailFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          onFieldSubmitted: (_){
                            setState(() {
                              _passwordFocusNode.unfocus();
                            });
                          },
                          cursorColor: MyCustomColors.blue(),
                          cursorHeight: scale_height(MyCustomFonts.twenty, context),
                          obscureText: _hidePasswordState,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: scale_height(2.089, context),),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context)),
                            prefixIcon: _passwordFocusNode.hasFocus? Icon(Icons.lock_outlined, color: MyCustomColors.blue()) : Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              onPressed: _hidePasswordState == true? disable: enable,
                              icon: _passwordFocusNode.hasFocus? Icon(_lockPasswordIcon, color: MyCustomColors.blue()) : Icon(_lockPasswordIcon),
                              iconSize: 19.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyCustomColors.blue())),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: scale_height(4.5, context)),
                        height: scale_height(6.388, context),
                        width: scale_width(91.505, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: RaisedButton(
                          color: MyCustomColors.blue(),
                          onPressed: validate,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Login', style: TextStyle(color: Colors.white, fontSize: scale_height(MyCustomFonts.nineteen, context)),)
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: scale_height(4.5, context), right: scale_width(1.5, context)),
                            height: 0.3,
                            width: scale_width(37.0, context),
                            color: Colors.black,
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: scale_height(4.75, context)),
                              child: Text('Or', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),)),
                          Container(
                            margin: EdgeInsets.only(bottom: scale_height(4.5, context), left: scale_width(1.5, context)),
                            height: 0.3,
                            width: scale_width(37.0, context),
                            color: Colors.black,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: scale_height(9.0, context)),
                        height: scale_height(6.388, context),
                        width: scale_width(91.505, context),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyCustomColors.blue(), width: 1.3),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Register', style: TextStyle(color: MyCustomColors.blue(), fontSize: scale_height(MyCustomFonts.nineteen, context)),)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
