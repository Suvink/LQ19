import 'package:flutter/material.dart';

class livescores extends StatefulWidget {
  @override
  _LivescoreState createState() => _LivescoreState();
}

class _LivescoreState extends State<livescores> {
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

    //Live Status
    final livestatus = new Transform(
      transform: new Matrix4.identity()..scale(0.8),
      alignment: Alignment(0.0, 0.0),
      child: new Chip(
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        backgroundColor: Color(0xFFF31046),
        label: Text("• LIVE",
            style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center),
      ),
    );

    //Logo
    final crest = new Center(
      child: Image(
        image: AssetImage("./assets/crest_rcg.png"),
        height: 79.0,
        width: 64.0,
      ),
    );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child:
          Text("144/4", style: TextStyle(fontSize: 72.0, color: Colors.white)),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text("32.2 Overs",
          style: TextStyle(fontSize: 24.0, color: Color(0xFFB4B4B4))),
    );

    //This Over Title
    final thisOverTitle = new Container(
      alignment: Alignment(0.0, 0.0),
      child: Text(
        "This Over",
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
    );

    final scoreball = new Container(
      padding: EdgeInsets.only(top: 5.0),
      width: 26.0,
      height: 26.0,
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(1.0),
            const Color(0xFFE207D7).withOpacity(1.0)
          ],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
      ),
      child: new Text(
        "1",
        style: TextStyle(fontSize: 13.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

    //Scoreballs Wrapper
    final scoreballsSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          scoreball,
          scoreball,
          scoreball,
          scoreball,
          scoreball,
          scoreball
        ],
      ),
    );

    //Extras Title
    final extrasTitle = new Container(
      margin: EdgeInsets.only(top: 5.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(
        "Extras",
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
    );

    //Extras Wrapper
    final extrasSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          scoreball,
          scoreball,
          scoreball,
          scoreball,
        ],
      ),
    );


  //var totalExtras = ;


    final totalextras = Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 30.0,
      alignment: Alignment(0.0, 0.0),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          Text(
            "4\nTotal Extras",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "2\n Wides",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "0\n No Balls",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "1\n Leg Bys",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
















    //Main Container
    final mainContainer = new Container(
      height: 437.0,
      width: 348.0,
      margin: new EdgeInsets.all(13.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(0.32),
            const Color(0xFFE207D7).withOpacity(0.34)
          ],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
        borderRadius: new BorderRadius.all(Radius.circular(35.0)),
      ),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          livestatus,
          crest,
          score,
          overs,
          thisOverTitle,
          scoreballsSet,
          extrasTitle,
          extrasSet,
          totalextras
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
