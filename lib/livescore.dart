import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'highlights.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

class livescores extends StatefulWidget {
  @override
  _LivescoreState createState() => _LivescoreState();
}

class scoreBall extends StatelessWidget {
  const scoreBall({
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
      child: new AutoSizeText(
        score,
        style: TextStyle(fontSize: 13.0, color: Colors.white),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}

class _LivescoreState extends State<livescores> {
  final String url = "https://raw.githubusercontent.com/Suvink/MekaJsonEkak/master/lq.json";


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
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body);

    setState(() {
      //jsonState = data['setState'];
      jsonStatus = data['string'];
      jsonScore = data['score'];
      jsonOvers = data['overs'].toString() + " Overs";
      jsonBattingTeam = data['battingTeam'];

      if (jsonBattingTeam == "RICHMOND") {
        jsonCrest = "assets/crest_rcg.png";
      } else {
        jsonCrest = "assets/crest_mcg.png";
      }

      //Batsman and Bowlers details
      jsonBatsmanOne = data['batsmanOne']['name'].toString() + "*";
      jsonBatsmanOneScore = data['batsmanOne']['runs'].toString();
      jsonBatsmanTwo = data['batsmanTwo']['name'].toString();
      jsonBatsmanTwoScore = data['batsmanTwo']['runs'].toString();
      jsonBowler = data['bowlerOne']['name'].toString();
      jsonBowlerScore = data['bowlerOne']['figures'].toString();

      jsonRunrate = data['runRate'];
      jsonTotalExtras =data['extras']['totalExtras'].toString() + "\nTotal Extras";
      jsonNoBalls = data['extras']['noBalls'].toString() + "\nNo Balls";
      jsonWides = data['extras']['wides'].toString() + "\nWides";
      jsonLegByes = data['extras']['legByes'].toString() + "\nLeg Byes";
    });

    print(jsonState.toString());
    print(jsonStatus.toString());
  }

/*
  Future<String> getJsonData() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var data = jsonDecode(response.body);
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(
        top: 5.0,
        bottom: 10.0
      ),
      child: new AutoSizeText("Richmond Live",
          style: TextStyle(
              fontSize: 24.0, fontFamily: "Montserrat", color: Colors.white)),
    );

    _showInstructions() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            elevation: 2.0,
            title: new AutoSizeText("Instructions",maxLines: 1,textAlign: TextAlign.center,),
            content: new Text("1. Tap on the top card for the highlights and pitch report\n\n2. Swipe from left or right for school teams."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    //Instructions Button
    final btnhelp = new IconButton(
      alignment: Alignment.topRight,
      icon: Icon(Icons.menu),
      onPressed: _showInstructions,
      iconSize: 30.0,
      tooltip: "Instructions",
    );

    //Logo
    final crestImage = new Center(
      child: Image(
        image: AssetImage(jsonCrest.toString()),
        height: 79.0,
        width: 64.0,
      ),
    );

    final crest = new Stack(
      children: <Widget>[
        btnhelp,
        crestImage
      ],
    );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: AutoSizeText(
        jsonScore.toString(),
        style: TextStyle(fontSize: 72.0, color: Color(0xFF404040)),
        maxLines: 1,
      ),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: AutoSizeText(
        jsonOvers.toString(),
        style: TextStyle(fontSize: 24.0, color: Color(0xFF404040)),
        maxLines: 1,
      ),
    );

    //This Over Title
    final thisOverTitle = new Container(
      alignment: Alignment(0.0, 0.0),
      child: AutoSizeText(
        "This Over",
        style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
        maxLines: 1,
      ),
    );

    //Scoreballs Wrapper
    final scoreballsSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new scoreBall(score: "1"),
          new scoreBall(score: "2"),
          new scoreBall(score: "3"),
          new scoreBall(score: "4"),
          new scoreBall(score: "w"),
          new scoreBall(score: "nb"),
        ],
      ),
    );

    //Extras Title
    final extrasTitle = new Container(
      margin: EdgeInsets.only(top: 5.0),
      alignment: Alignment(0.0, 0.0),
      child: AutoSizeText(
        "Extras",
        style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
      ),
    );

    //Extras Wrapper
    final extrasSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new scoreBall(score: "lb"),
          new scoreBall(score: "w"),
          new scoreBall(score: "nb"),
          new scoreBall(score: "w")
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
          AutoSizeText(
            jsonTotalExtras.toString(),
            style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(width: 15.0),
          AutoSizeText(
            jsonWides.toString(),
            maxLines: 2,
            style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          AutoSizeText(
            jsonNoBalls.toString(),
            style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(width: 15.0),
          AutoSizeText(
            jsonLegByes.toString(),
            style: TextStyle(fontSize: 14.0, color: Color(0xFF404040)),
            textAlign: TextAlign.center,
            maxLines: 2,
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
                  child: FittedBox(
                    child: AutoSizeText(
                      "Batting",
                      style: TextStyle(fontSize: 24.0),
                      maxLines: 1,
                    ),
                  ),
                  baseColor: Color(0xFF404040),
                  highlightColor: Colors.grey)),
          SizedBox(width: 25.0),
          new Container(
              child: Image(
            image: AssetImage("./assets/Bowler.png"),
            height: 94.0,
            width: 53.0,
          )),
          new FittedBox(
              child: new Shimmer.fromColors(
                  child: AutoSizeText(
                    "Bowling",
                    style: TextStyle(fontSize: 24.0),
                    maxLines: 1,
                  ),
                  baseColor: Color(0xFF404040),
                  highlightColor: Colors.grey)),
        ],
      ),
    );

    final batsmanDetails = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          new Container(
              child: AutoSizeText(
            jsonBatsmanOne.toString(),
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: AutoSizeText(
                jsonBatsmanOneScore.toString(),
                style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
                maxLines: 1,
              )),
          new Container(
              child: AutoSizeText(
            jsonBatsmanTwo.toString(),
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
          )),
          new Container(
              child: AutoSizeText(
            jsonBatsmanTwoScore.toString(),
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
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
              child: AutoSizeText(
            jsonBowler.toString(),
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: AutoSizeText(
                jsonBowlerScore.toString(),
                style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
                maxLines: 1,
              )),
          new Container(
              child: AutoSizeText(
            "Run Rate",
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
          )),
          new Container(
              child: AutoSizeText(
            jsonRunrate.toString(),
            style: TextStyle(fontSize: 12.0, color: Color(0xFF404040)),
            maxLines: 1,
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
        margin: EdgeInsets.only(left: 15.0, right: 10.0,bottom: 25.0),
        child: new Shimmer.fromColors(
            child: AutoSizeText(
              jsonStatus.toString(),
              maxLines: 4,
              style: TextStyle(fontSize: 12.0),
            ),
            baseColor: Color(0xFF404040),
            highlightColor: Colors.grey));

    //Main Container
    final mainContainer = new GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => highlights()));
      },
      child: new FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: new EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFFFFFFFF).withOpacity(1.0),
                const Color(0xFFFFFFFF).withOpacity(1.0)
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
              bottomTitleSection,
              batsmanandbowler,
              lineSeperator,
              statusBar
            ],
          ),
        ),
      ),
    );

    final bottomContainer = new FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: new EdgeInsets.all(13.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              const Color(0xFFFFFFFF).withOpacity(1.0),
              const Color(0xFFFFFFFF).withOpacity(1.0)
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
      ),
    );


    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF300e57),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title,mainContainer],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF300e57).withOpacity(0.7),
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
  const url = 'https://www.youtube.com/watch?v=S9RlUXteNnw';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch live stream! Check Your connection!';
  }
}

