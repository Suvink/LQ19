import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class teamRcgs extends StatefulWidget {
  @override
  _teamRcgState createState() => _teamRcgState();
}

class _teamRcgState extends State<teamRcgs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    //Team title
    final teamTitle = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 15.0),
      child: new Text("Richmond College",
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Montserrat",
              color: Color(0xFFFFFFFF).withOpacity(0.5))),
    );

    final schoolName = new Container(
      margin: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment(0.0, 0.0),
      child: new Text("First XI Cricket Team",
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Montserrat",
              color: Color(0xFFFFFFFF))),
    );

    //Player Row1
    final playerRow1 = new Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: Image(
              image: AssetImage("./assets/player.png"),
              height: 81.0,
              width: 65.0,
            ),
          ),
          SizedBox(width: 20.0),
          new Container(
            child: Image(
              image: AssetImage("./assets/player.png"),
              height: 81.0,
              width: 65.0,
            ),
          ),
          SizedBox(width: 20.0),
          new Container(
            child: Image(
              image: AssetImage("./assets/player.png"),
              height: 81.0,
              width: 65.0,
            ),
          ),
        ],
      ),
    );

    //Coach and MIC
    final trainers = new Container(
      margin: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment(0.0, 0.0),
      child: new Text(
        "Mr. Maithreepala Sirisena(Coach)\nMr. Deepal Epa(MIC)",
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );

    //Main Container
    final mainContainer = new Container(
      width: 348.0,
      margin: new EdgeInsets.all(13.0),
      padding: EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(0.22),
            const Color(0xFFE207D7).withOpacity(0.24)
          ],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
        borderRadius: new BorderRadius.all(Radius.circular(35.0)),
      ),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          teamTitle,
          schoolName,
          playerRow1,
          playerRow1,
          playerRow1,
          playerRow1,
          trainers
        ],
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
