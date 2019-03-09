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
      height: 26.0,
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: new LinearGradient(
          colors: [
            const Color(0xFF9b418f).withOpacity(1.0),
            const Color(0xFF300e57).withOpacity(1.0)
          ],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
      ),
      child: Text(score),
    );
  }
}