import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradePage extends StatefulWidget {
  var x;
  GradePage({Key key, @required this.x}) : super(key: key);
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage>{
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: Text(widget.x.subject),
        ),
    ),
      );
  }
}