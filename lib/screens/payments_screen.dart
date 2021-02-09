import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trko/utils/UI%20responsiveness.dart';
import 'package:trko/utils/theme.dart';


class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {


  var balance = List.generate(8, (index) => 'Balance');
  var amount = List.generate(8, (index) => 'Amount');
  var paid = List.generate(8, (index) => 'Paid');
  bool visible01 = true;
  bool visible02 = false;
  IconData _dropdownIcon = Icons.arrow_drop_down;
  var projects = List<String>.generate(100, (index) => 'Project ${index + 1}');

  enable01(){
    setState(() {
        visible01 = true;
        _dropdownIcon = Icons.arrow_drop_up;
    });
  }

  enable02(){
    setState(() {
        visible02 = true;
        _dropdownIcon = Icons.arrow_drop_up;
    });
  }

  disable01(){
    setState(() {
        visible01 = false;
        _dropdownIcon = Icons.arrow_drop_down;
    });
  }
  disable02(){
    setState(() {
        visible02 = false;
        _dropdownIcon = Icons.arrow_drop_down;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: MyCustomColors.blue(),
        title: Text('Payments', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context),),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: scale_height(3.071, context)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: scale_height(0.7, context),left: scale_width(3.884, context), right: scale_width(3.884, context), ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Balance:', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                    Text('N${Random().nextInt(1000)},${Random().nextInt(1000)},${Random().nextInt(1000)},${Random().nextInt(1000)},${Random().nextInt(1000)}',
                      style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                  ],
                ),
              ),
              // first payment history
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: scale_height(0.614 , context)),
                      color: MyCustomColors.blue(),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: Text('This Month', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context,), fontWeight: FontWeight.w500),),
                            trailing: Icon(_dropdownIcon),
                            onTap: visible01 == false? enable01 : disable01,
                          ),
                        ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: scale_width(3.884 , context)),
                      child: Visibility(
                        visible: visible01,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: amount.length,
                          itemBuilder: (context, index){
                            return Container(
                              margin: EdgeInsets.only(bottom: scale_height(0.491, context)),
                              decoration: BoxDecoration(
                                border: Border(bottom: index == amount.length -1? BorderSide.none: BorderSide(width: 0.5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${projects[index]}', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context)),),
                                      SizedBox(height: 5.0,),
                                      Text('Feburary ${(index) + 6}')
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: scale_height(0.246, context),),
                                        Container(
                                          child: Text('${amount[index]}: N${Random().nextInt(100) + 5},${Random().nextInt(1000)},${Random().nextInt(1000)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.614, context),),
                                        Container(
                                          child: Text('${paid[index]}: N${Random().nextInt(10) + 5},${Random().nextInt(1000)},${Random().nextInt(1000)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.614, context),),
                                        Container(
                                          child: Text('${balance[index]}: N${Random().nextInt(10) + 5},${Random().nextInt(1000)},${Random().nextInt(100)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.246, context),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // second payment history
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: scale_height(0.614 , context)),
                      color: MyCustomColors.blue(),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: Text('January 2021', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context), fontWeight: FontWeight.w500),),
                            trailing: Icon(_dropdownIcon),
                            onTap: visible02 == false? enable02 : disable02,
                          ),
                        ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: scale_width(3.884 , context)),
                      child: Visibility(
                        visible: visible02,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: amount.length,
                          itemBuilder: (context, index){
                            return Container(
                              margin: EdgeInsets.only(bottom: scale_height(0.491, context)),
                              decoration: BoxDecoration(
                                border: Border(bottom: index == amount.length -1? BorderSide.none: BorderSide(width: 0.5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${projects[index]}', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context)),),
                                      SizedBox(height: 5.0,),
                                      Text('January ${(index) + 10}')
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: scale_height(0.246, context),),
                                        Container(
                                          child: Text('${amount[index]}: N${Random().nextInt(100) + 5},${Random().nextInt(1000)},${Random().nextInt(1000)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.614, context),),
                                        Container(
                                          child: Text('${paid[index]}: N${Random().nextInt(10) + 5},${Random().nextInt(1000)},${Random().nextInt(1000)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.614, context),),
                                        Container(
                                          child: Text('${balance[index]}: N${Random().nextInt(10) + 5},${Random().nextInt(1000)},${Random().nextInt(100)}',
                                            style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context)),),
                                        ),
                                        SizedBox(height: scale_height(0.246, context),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
