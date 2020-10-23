import 'package:flutter/material.dart';

class DocumentPage extends StatefulWidget {
  var x;
  DocumentPage({Key key, @required this.x}) : super(key: key);
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.x.subject),
          ),
          body: Column(
            children: <Widget>[Text("data")],
          )
      ),
    );
  }
}
