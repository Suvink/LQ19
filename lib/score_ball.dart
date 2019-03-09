import 'package:flutter/material.dart';

class ScoreBall extends StatelessWidget {
  const ScoreBall({
    Key key,
    this.score,
  }) : super(key: key);

  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5.0),
        width: 26.0,
        height: 30.0,
        margin: EdgeInsets.only(left: 5.0),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment(0.8, 0.0),
            colors: [
              const Color(0xFF300e57),
              const Color(0xFF9b418f),
            ],
          ),
        ),
        child: Center(
          child: Text(score,
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
        ));
  }
}
