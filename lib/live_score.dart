import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'highlights.dart';
import 'score_ball.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveScores extends StatefulWidget {
  const LiveScores({Key key}) : super(key: key);

  @override
  _LiveScoreState createState() => _LiveScoreState();
}

class _LiveScoreState extends State<LiveScores> {
  String _crest;
  String _score;
  String _overs;
  String _status;
  String _batsmanOne;
  String _batsmanTwo;
  String _bowler;
  String _runrate;
  String _battingTeam;
  String _batsmanOneScore;
  String _batsmanTwoScore;
  String _bowlerScore;
  String _lastWicket;
  List _recentOver;
  List _recentOverExtras;
  int _totalextras;
  int _noBalls;
  int _wides;
  int _legByes;

  @override
  Widget build(BuildContext context) {
    http
        .get(
            'https://raw.githubusercontent.com/Suvink/MekaJsonEkak/master/lq.json')
        .then((response) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _crest = data['crest'];
        _score = data['score'];
        _overs = data['overs'];
        _status = data['string'];
        _batsmanOne = data['batsmanOne']['name'];
        _batsmanTwo = data['batsmanTwo']['name'];
        _bowler = data['bowler']['name'];
        _runrate = data['runRate'];
        _battingTeam = data['battingTeam'];
        _batsmanOneScore = data['batsmanOne']['runs'];
        _batsmanTwoScore = data['batsmanTwo']['runs'];
        _bowlerScore = data['bowler']['figures'];
        _totalextras = data['extras']['totalExtras'];
        _noBalls = data['extras']['noBalls'];
        _wides = data['extras']['wides'];
        _legByes = data['extras']['legByes'];
        _lastWicket = data['lastWicket'];
        _recentOver = data['recentOver'];
      });
    });

    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Text("Richmond Live"),
    );

    //Logo
    final crestImage = new Center(
      child: Image(
        image: AssetImage(_crest),
        height: 79.0,
        width: 64.0,
      ),
    );

    final crest = new Stack(
      children: <Widget>[crestImage],
    );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(_score),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(_overs),
    );

    //This Over Title
    final thisOverTitle =
        new Container(alignment: Alignment(0.0, 0.0), child: Text('This Over'));

    // Create Ball List
    var thisOver = List<Widget>();
    for (String ball in _recentOver) {
      thisOver.add(new ScoreBall(score: ball));
    }

    //Scoreballs Wrapper
    final scoreballsSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center, children: thisOver),
    );

    //Extras Title
    final extrasTitle = new Container(
      margin: EdgeInsets.only(top: 5.0),
      alignment: Alignment(0.0, 0.0),
      child: Text('Extras'),
    );

    // Create Extras List
    var extras = List<Widget>();
    for (String ball in _recentOverExtras) {
      extras.add(new ScoreBall(score: ball));
    }

    //Extras Wrapper
    final extrasSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center, children: extras),
    );

    final totalextras = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 30.0,
      alignment: Alignment(0.0, 0.0),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          Text('$_totalextras'),
          SizedBox(width: 15.0),
          Text('$_wides'),
          SizedBox(width: 15.0),
          Text('$_noBalls'),
          SizedBox(width: 15.0),
          Text('$_legByes')
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
                    child: Text('Batting'),
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
          new FittedBox(child: Text("Bowling"))
        ],
      ),
    );

    final batsmanDetails = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          Text(_batsmanOne),
          Text(_batsmanOneScore),
          Text(_batsmanTwo),
          Text(_batsmanTwoScore),
        ],
      ),
    );

    final bowlerDetails = new Container(
      alignment: Alignment(1.0, 0.0),
      margin: EdgeInsets.only(left: 15.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Text(_bowler),
          Text(_bowlerScore),
          Text(_runrate),
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
        margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 25.0),
        child: new Shimmer.fromColors(
            child: Text(_status),
            baseColor: Color(0xFF404040),
            highlightColor: Colors.grey));

    final summeryCard = new FittedBox(
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
    );

    //Main Container
    final mainContainer = new GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => highlights()));
        },
        child: summeryCard);

    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF300e57),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title, mainContainer],
          ),
        ),
      ),
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
