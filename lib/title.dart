import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 30, left: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "BMI",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Text(
            "Calculator",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: 'Poppins'),
          )
        ]));
  }
}
