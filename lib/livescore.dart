import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'highlights.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class livescores extends StatefulWidget {
  @override
  _LivescoreState createState() => _LivescoreState();
}

class _LivescoreState extends State<livescores> {

  final String url = "https://api.myjson.com/bins/173mx6";
  var jsonCrest;
  var jsonScore;
  var jsonOvers;
  var jsonState;
  var jsonStatus;
  var jsonBatsmanOne;
  var jsonBatsmanTwo;
  var jsonBowler;
  var jsonRunrate;
  var jsonBattingTeam;
  var jsonTotalExtras;
  var jsonNoBalls;
  var jsonWides;
  var jsonLegByes;
  var jsonBatsmanOneScore;
  var jsonBatsmanTwoScore;
  var jsonBowlerScore;


  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    http.Response response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);

    setState(() {
      //jsonState = data['setState'];
      jsonStatus = data['string'];
      jsonScore = data['score'];
      jsonOvers =data['overs'].toString() + " Overs";
      jsonBattingTeam = data['battingTeam'];

      if (jsonBattingTeam == "RICHMOND"){
        jsonCrest = "assets/crest_rcg.png";
      } else{
        jsonCrest = "assets/crest_mcg.png";
      }

      //Batsman and Bowlers details
      jsonBatsmanOne = data['batsmanOne']['name'].toString()  + "*" ;
      jsonBatsmanOneScore = data['batsmanOne']['runs'].toString();
      jsonBatsmanTwo = data['batsmanTwo']['name'].toString() ;
      jsonBatsmanTwoScore = data['batsmanTwo']['runs'].toString();
      jsonBowler = data['bowlerOne']['name'].toString();
      jsonBowlerScore = data['bowlerOne']['figures'].toString();


      jsonRunrate = data['runRate'];
      jsonTotalExtras = data['extras']['totalExtras'].toString() + "\nTotal Extras";
      jsonNoBalls = data['extras']['noBalls'].toString() + "\nNo Balls";
      jsonWides = data['extras']['wides'].toString() + "\nWides";
      jsonLegByes = data['extras']['legByes'].toString() + "\nLeg Byes";


    });

    print(jsonState.toString());
    print(jsonStatus.toString());

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

/*
    final bla = new Shimmer.fromColors(
        child: new Text("Hello asdma csfn fkjawfmak fwfmw"),
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        direction: ShimmerDirection.ltr,
    );
*/

    //Logo
    final crest = new Center(
      child: Image(
        image: AssetImage(jsonCrest.toString()),
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
          Text(jsonScore.toString(), style: TextStyle(fontSize: 72.0, color: Colors.white)),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(jsonOvers.toString(),
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

    final totalextras = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 30.0,
      alignment: Alignment(0.0, 0.0),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          Text(
            jsonTotalExtras.toString(),
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            jsonWides.toString(),
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            jsonNoBalls.toString(),
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            jsonLegByes.toString(),
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );

    //Batsman and Bowler details
    final bottomTitleSection = new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: Image(
              image: AssetImage("./assets/batsman.png"),
              height: 94.0,
              width: 53.0,
            ),
          ),
          new Container(
              child: new Shimmer.fromColors(
                  child: Text(
                    "Batting",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey)),
          SizedBox(width: 25.0),
          new Container(
              child: Shimmer(
            child: Image(
              image: AssetImage("./assets/Bowler.png"),
              height: 94.0,
              width: 53.0,
            ),
            gradient: new LinearGradient(
              colors: [const Color(0xFFA220FF), const Color(0xFFE207D7)],
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
            ),
            direction: ShimmerDirection.ttb,
          )),
          new Container(
              child: new Shimmer.fromColors(
                  child: Text(
                    "Bowling",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey)),
        ],
      ),
    );

    final batsmanDetails = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          new Container(
              child: Text(
            jsonBatsmanOne.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                jsonBatsmanOneScore.toString(),
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              )),
          new Container(
              child: Text(
            jsonBatsmanTwo.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
          new Container(
              child: Text(
            jsonBatsmanTwoScore.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
        ],
      ),
    );

    final bowlerDetails = new Container(
      alignment: Alignment(1.0, 0.0),
      margin: EdgeInsets.only(left: 15.0, right: 10.0),
      child: Column(
        children: <Widget>[
          new Container(
              child: Text(
            jsonBowler.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                jsonBowlerScore.toString(),
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              )),
          new Container(
              child: Text(
            "Run Rate",
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
          new Container(
              child: Text(
            jsonRunrate.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )),
        ],
      ),
    );

    //Batsman and Bowler Wrapper
    final batsmanandbowler = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[batsmanDetails, bowlerDetails],
    );

    //Line separator
    final lineSeperator = new Container(
      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
      height: 2.0,
      color: Color(0xFFBCB8B8),
    );

    //StatusBar
    final statusBar = new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Shimmer.fromColors(
            child: Text(
              jsonStatus.toString(),
              style: TextStyle(fontSize: 12.0),
            ),
            baseColor: Colors.white,
            highlightColor: Colors.grey));

    //Main Container
    final mainContainer = new GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => highlights()));
      },
      child: new Container(
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
            //bla,
            crest,
            score,
            overs,
            thisOverTitle,
            scoreballsSet,
            extrasTitle,
            extrasSet,
            totalextras,
          ],
        ),
      ),
    );

    final bottomContainer = new Container(
      height: 253.0,
      width: 348.0,
      margin: new EdgeInsets.all(13.0),
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
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          bottomTitleSection,
          batsmanandbowler,
          lineSeperator,
          statusBar
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
            children: <Widget>[title, mainContainer, bottomContainer],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE207D7).withOpacity(0.7),
        onPressed: _launchURL,
        tooltip: 'Live Stream',
        child: Icon(Icons.live_tv),
        elevation: 2.0,
      ),
    );
  }
}

//Youtube launch function
_launchURL() async {
  const url = 'https://www.youtube.com/watch?v=vWfjlIMiqBg';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch live stream! Check Your connection!';
  }
}
