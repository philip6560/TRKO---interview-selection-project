import 'package:flutter/material.dart';
import 'package:trko/utils/UI%20responsiveness.dart';
import 'package:trko/utils/theme.dart';


class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  var projects = List<String>.generate(100, (index) => 'Project ${index + 1}');
  var description = List<String>.generate(100, (index) => 'This is a simple description');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: MyCustomColors.blue(),
        title: Text('Projects', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context),),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: scale_height(1.720, context), left: scale_width(7.524, context), right: scale_width(7.282, context)),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: projects.length,
          itemBuilder: (context, index){
            return Card(
              child: Container(
                width: scale_width(85.194, context),
                height: scale_height(11.794, context),
                margin: EdgeInsets.only(top: scale_height(2.948, context),),
                child: ListTile(
                  title: Container(
                    height: scale_height(2.948, context),
                    width: scale_width(20.874, context),
                    child: Text('${projects[index]}', style: TextStyle(fontSize: scale_height(MyCustomFonts.twenty, context)),)
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: scale_height(1.0, context)),
                      width: scale_width(46.845, context),
                      height: scale_height(2.457, context),
                      child: Text('${description[index]}', style: TextStyle(fontSize: scale_height(MyCustomFonts.sixteen, context),)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
