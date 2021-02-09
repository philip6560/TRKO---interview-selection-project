import 'package:flutter/material.dart';
import 'package:trko/utils/UI%20responsiveness.dart';
import 'package:trko/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';


class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  Color themeColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text('Contact', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context)),),
        backgroundColor: MyCustomColors.blue(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: scale_width(0.971, context), left: scale_width(1.214, context)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: scale_height(3.182, context)),
                alignment: Alignment.centerLeft,
                child: Text('We are available to support you all the way.\nReach out to us', style: TextStyle(fontSize: scale_height(MyCustomFonts.nineteen, context), color: themeColor, fontWeight: FontWeight.w600),),
              ),
              Container(
                margin: EdgeInsets.only(top: scale_height(3.5, context), bottom: scale_height(2.7, context)),
                child: Image.asset('assets/map.jpg', fit: BoxFit.cover,),
              ),
              Container(
                margin: EdgeInsets.only(bottom: scale_height(2.4, context)),
                alignment: Alignment.centerLeft,
                child: Text('12, Ezekiel Street,\nIkeja,\nLagos state.', style: TextStyle(color: themeColor, fontSize: scale_height(MyCustomFonts.eighteen, context)),),
              ),
              Container(
                margin: EdgeInsets.only(bottom: scale_height(2.4, context)),
                child: Row(
                  children: [
                    Icon(Icons.phone_android, color: themeColor,),
                    SizedBox(width: 3.0,),
                    Text('+2348161195518, +2348038320672', style:   TextStyle(color: themeColor, fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: scale_height(6.5, context)),
                child: Row(
                  children: [
                    Icon(Icons.email, color: themeColor,),
                    SizedBox(width: 4.0,),
                    Text('support@specialmansolution.com', style: TextStyle(color: themeColor, fontSize: scale_height(MyCustomFonts.sixteen, context)), ),
                  ],
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: scale_height(1.229, context), top: scale_height(1.72, context)),
                child: Text('Connect With Us On Social Media', style: TextStyle(fontSize: scale_height(MyCustomFonts.eighteen, context)),),
              ),
              Container(
                margin: EdgeInsets.only(top: scale_height(1.229, context)),
                color: MyCustomColors.blue(),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Image.asset('assets/whatsapp-brands.png', color: themeColor, width: scale_width(8.01, context), height: scale_height(3.686, context),),
                      trailing: Text('WhatsApp', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context), color: themeColor),),
                      onTap: () async{
                        String url = 'https://api.whatsapp.com/send?phone=2347015152515&text=Hello%2C%20Good%20day%20and%20how%20may%20we%20be%20of%20service%20to%20you%3F';
                        if(await canLaunch(url)){
                          await launch(url);
                        }
                        else{
                          return SnackBar(content: Text('Could not contact support centre'), duration: Duration(seconds: 5),);
                        }
                      },
                    ),
                    Divider(thickness: 2.0, color: Colors.white,),
                    ListTile(
                      leading: Image.asset('assets/facebook-square-brands.png', color: themeColor, width: scale_width(8.01, context), height: scale_height(3.686, context),),
                      trailing: Text('Facebook', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context), color: themeColor),),
                      onTap: ()async{
                        String url = 'https://m.facebook.com/specialmansolution/';
                        if(await canLaunch(url)){
                          await launch(url);
                        }else{
                          return SnackBar(content: Text('Could not contact support centre'), duration: Duration(seconds: 5),);
                        }
                      },
                    ),
                    Divider(thickness: 2.0, color: Colors.white,),
                    ListTile(
                      leading: Image.asset('assets/twitter-brands.png', color: themeColor, width: scale_width(8.01, context), height: scale_height(3.686, context),),
                      trailing: Text('Twitter', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context), color: themeColor),),
                      onTap: ()async{
                        String url = 'https://mobile.twitter.com/SGSGlobal';
                        if(await canLaunch(url)){
                          await launch(url);
                        }else{
                          return SnackBar(content: Text('Could not contact support centre'), duration: Duration(seconds: 5),);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
