import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final Widget page;
  const Header({Key key, this.page}) : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    double screenWidth, screenheight;
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenWidth = size.width;
    return Container(
      width: screenWidth,
      height: screenheight * .15,
      decoration: BoxDecoration(
        color: Color.fromRGBO(4, 107, 175, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(1.0, 6),
          ),
        ],
      ),
      child: Image.asset('assets/open.png'),
    );
  }
}
