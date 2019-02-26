import 'package:flutter/material.dart';
import 'livescore.dart';

class highlights extends StatefulWidget {
  @override
  _highlightsState createState() => _highlightsState();
}

class _highlightsState extends State<highlights> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Text Shader
    final Shader textShader = LinearGradient(
      colors: <Color>[Color(0xFF404040), Color(0xFF404040)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(
        top: 5.0,
      ),
      child: new Text("Richmond Live",
          style: TextStyle(
              fontSize: 24.0, fontFamily: "Montserrat", color: Colors.white)),
    );

    //Day1
    final dayTitle = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 15.0),
      child: new Text("Day 1",
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Montserrat",
              color: Color(0xFF404040))),
    );

    //PitchReportTitle
    final pitchReportTitle = new Container(
      child: new Text(
        "Pitch Report",
        style: TextStyle(
            fontSize: 24.0,
            fontFamily: "Montserrat",
            foreground: Paint()..shader = textShader),
        textAlign: TextAlign.center,
      ),
    );

    //PitchReport
    final pitchReport = new Container(
        alignment: Alignment(0.0, 0.0),
        margin: EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0),
        child: Text(
          "Groundsman Kevin Mitchell jnr said of the surface: “The pace holds together well and it can turn towards the end so everyone gets a chance. You can have a poor session and still get out of trouble which we saw a couple of Ashes series ago (when England drew ending a run of successive Australia wins at the GABBA).”Groundsman Kevin Mitchell jnr said of the surface: “The pace holds together well and it can turn towards the end so everyone gets a chance. You can have a poor session and still get out of trouble which we saw a couple of Ashes series ago (when England drew ending a run of successive Australia wins at the GABBA).",
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: "Montserrat",
            color: Color(0xFF404040),
          ),
          textAlign: TextAlign.justify,
        ));

    //Line seperator
    final lineSeperator = new Container(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
      height: 2.0,
      color: Color(0xFF404040),
    );

    //Main Container
    final mainContainer = new GestureDetector(
      //onVerticalDragEnd: Navigator.push(context, MaterialPageRoute(builder: (context) => livescores())),
      child: new Container(
        width: 348.0,
        margin: new EdgeInsets.all(13.0),
        padding: EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              const Color(0xFFFFFFFF),
              const Color(0xFFFFFFFF)
            ],
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(35.0)),
        ),
        child: new ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            dayTitle,
            pitchReportTitle,
            pitchReport,
            lineSeperator,
            dayTitle,
            pitchReportTitle,
            pitchReport,
            lineSeperator
          ],
        ),
      ),
    );

    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF0F0755),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title, mainContainer],
          ),
        ),
      ),
    );
  }
}
