
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:trko/utils/UI responsiveness.dart';
import 'package:trko/utils/theme.dart';
import 'package:trko/database/db_helper.dart';
import 'package:trko/database/models/users.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  var dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _retypepasswordFocusNode;
  bool _hidePasswordStateOne = true;
  bool _hidePasswordStateTwo = true;
  IconData _lockPasswordIconOne = MyCustomIcons.eye_slash_regular;
  IconData _lockPasswordIconTwo = MyCustomIcons.eye_slash_regular;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController retyperpasswordcontroller = TextEditingController();
  var email;
  var password;
  var retypepassword;
  String noMatch = 'Invalid Credentials. New Member? click register';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  void enable(){
    if(_passwordFocusNode.hasFocus){
      setState(() {
        _retypepasswordFocusNode.unfocus();
        _hidePasswordStateOne = true;
        _lockPasswordIconOne = MyCustomIcons.eye_slash_regular;
      });
    }
    if(_retypepasswordFocusNode.hasFocus) {
      setState(() {
        _passwordFocusNode.unfocus();
        _hidePasswordStateTwo = true;
        _lockPasswordIconTwo = MyCustomIcons.eye_slash_regular;
      });
    }
  }

  void disable(){
    if(_passwordFocusNode.hasFocus){
      setState(() {
        _retypepasswordFocusNode.unfocus();
        _hidePasswordStateOne = false;
        _lockPasswordIconOne = Icons.remove_red_eye_outlined;
      });
    }
    if(_retypepasswordFocusNode.hasFocus) {
      setState(() {
        _passwordFocusNode.unfocus();
        _hidePasswordStateTwo = false;
        _lockPasswordIconTwo = Icons.remove_red_eye_outlined;
      });
    }
  }



  loading(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Container(
            width: 100.0,
            height: 100.0,
            child: AlertDialog(
              content: Builder(
                builder: (context)=>Container(
                  height: scale_height(12.285, context),
                  width: scale_width(24.272, context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/trko_logo.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text('Please wait...', style: TextStyle(fontSize: scale_height(1.72, context)),)),
                ),
              ),
            )
        )
    );
  }


  create()async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      User user = User(id:null, email: email, password: password);
      var doesUserAlreadyExist = await dbHelper.getUser(email, password);
      if(doesUserAlreadyExist == noMatch) {
        await dbHelper.save(user);
        loading();
        await Future.delayed(Duration(seconds: 4));
        emailcontroller.clear();
        passwordcontroller.clear();
        retyperpasswordcontroller.clear();
        Navigator.pushNamed(context, '/home');
      }
      else{
        return _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('User with this email address already exist.',
          style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)), ),
        duration: Duration(seconds: 4), backgroundColor: MyCustomColors.blue(),),
        );
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordFocusNode = FocusNode();
    _retypepasswordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    dbHelper.getUsers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    _retypepasswordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(scale_width(22.573, context), scale_height(11.917, context), scale_width(22.573, context), 0.0),
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
              Container(
                margin: EdgeInsets.only(left: scale_width(9.223, context), right: scale_width(8.981, context)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: scale_width(91.505, context),
                        margin: EdgeInsets.only(bottom: scale_height(7.617, context)),
                        child: TextFormField(
                          validator: (val) {
                            if(EmailValidator.validate(val.toString())){
                              return null;
                            }else{
                              return 'Invalid email';
                            }
                          },
                          onSaved: (val){
                            setState(() {
                              email = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          focusNode: _emailFocusNode,
                          controller: emailcontroller,
                          onTap: (){
                            setState(() {
                              _retypepasswordFocusNode.unfocus();
                              _passwordFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          onFieldSubmitted: (_){
                            setState(() {
                              _retypepasswordFocusNode.unfocus();
                              _emailFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          cursorColor: MyCustomColors.blue(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: scale_height(2.089, context),),
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context), ),
                            prefixIcon: _emailFocusNode.hasFocus? Icon(Icons.email_outlined, color: MyCustomColors.blue(), size: scale_height(2.948, context),) : Icon(Icons.email_outlined, size: scale_height(2.948, context),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyCustomColors.blue())),
                          ),
                        ),
                      ),
                      Container(
                        width: scale_width(91.505, context),
                        margin: EdgeInsets.only(bottom: scale_height(7.124, context)),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordFocusNode,
                          controller: passwordcontroller,
                          validator: (val)=> val.isEmpty? 'Enter Password': null,
                          onSaved: (val){
                            setState(() {
                              password = val;
                            });
                          },
                          onTap: (){
                            setState(() {
                              _emailFocusNode.unfocus();
                              _retypepasswordFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          onFieldSubmitted: (_){
                            setState(() {
                              _emailFocusNode.unfocus();
                              _passwordFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_retypepasswordFocusNode);
                          },
                          cursorColor: MyCustomColors.blue(),
                          cursorHeight: scale_height(MyCustomFonts.twenty, context),
                          obscureText: _hidePasswordStateOne,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: scale_height(2.089, context),),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context),),
                            prefixIcon: _passwordFocusNode.hasFocus? Icon(Icons.lock_outlined, color: MyCustomColors.blue()) : Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              onPressed: _hidePasswordStateOne == true ? disable: enable,
                              icon: _passwordFocusNode.hasFocus? Icon(_lockPasswordIconOne, color: MyCustomColors.blue()) : Icon(_lockPasswordIconOne),
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
                        width: scale_width(91.505, context),
                        margin: EdgeInsets.only(bottom: scale_height(3.686, context)),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: _retypepasswordFocusNode,
                          controller: retyperpasswordcontroller,
                          validator: (val)=> val.isNotEmpty && val.toString() == passwordcontroller.text? null: 'Incorrect Password',
                          onTap: (){
                            setState(() {
                              _emailFocusNode.unfocus();
                              _passwordFocusNode.unfocus();
                            });
                            FocusScope.of(context).requestFocus(_retypepasswordFocusNode);
                          },
                          onFieldSubmitted: (_){
                            setState(() {
                              _retypepasswordFocusNode.unfocus();
                            });
                          },
                          cursorColor: MyCustomColors.blue(),
                          cursorHeight: scale_height(MyCustomFonts.twenty, context),
                          obscureText: _hidePasswordStateTwo,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: scale_height(2.089, context),),
                            hintText: 'Re-type Password',
                            hintStyle: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context),),
                            prefixIcon: _retypepasswordFocusNode.hasFocus? Icon(Icons.lock_outlined, color: MyCustomColors.blue()) : Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              onPressed: _hidePasswordStateTwo == true? disable: enable,
                              icon: _retypepasswordFocusNode.hasFocus? Icon(_lockPasswordIconTwo, color: MyCustomColors.blue()) : Icon(_lockPasswordIconTwo),
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
                          onPressed: create,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Register', style: TextStyle(color: Colors.white, fontSize: scale_height(MyCustomFonts.twenty, context)),)
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
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Login', style: TextStyle(color: MyCustomColors.blue(), fontSize: scale_height(MyCustomFonts.nineteen, context)),)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // i need to change the height of the container if i'm not adding extra text
            ],
          ),
        ),
      ),
    );
  }
}
