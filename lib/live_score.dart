import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String _streamURL =
      'https://www.youtube.com/channel/UC66Y9YztiHjs3H-kX8_OKPg';
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
  bool _isLoading = true;

  Future<Null> updateState() {
    // _isLoading = true;
    return http
        .get(
            'https://raw.githubusercontent.com/Suvink/MekaJsonEkak/master/lq.json')
        .then((http.Response response) {
      if (response.statusCode == 200) {
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
          _recentOver = data['recentOver'][0];
          _recentOverExtras = data['recentOver'][1];
          _isLoading = false;
          // _streamURL = data['steamURL'];
        });
      }
    });
  }

  //Youtube launch function
  _launchURL() async {
    if (await canLaunch(_streamURL)) {
      await launch(_streamURL);
    } else {
      throw 'Could not launch live stream! Check Your connection!';
    }
  }

  @override
  Widget build(BuildContext context) {
    updateState();

    if (_isLoading) {
      return new Scaffold(
        body: Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF300e57).withOpacity(0.7),
          onPressed: _launchURL,
          tooltip: 'Live Stream',
          child: Icon(Icons.live_tv),
          elevation: 2.0,
        ),
      );
    }

    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(top: 10.0),
      child: Text(
        "Richmond Live",
        textScaleFactor: 1.5,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );

    //Logo
    final crest = new Center(
      child: Image(
        image: AssetImage('assets/' + _crest),
        height: 79.0,
        width: 64.0,
      ),
    );

    // final crest = new Stack(
    //   children: <Widget>[crestImage],
    // );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(
        _score,
        textScaleFactor: 4,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(
        _overs + ' Overs',
        textScaleFactor: 2,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );

    //This Over Title
    final thisOverTitle = new Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment(0.0, 0.0),
        child: Text(
          'This Over',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ));

    // Create Ball List
    var thisOver = List<Widget>();
    for (var ball in _recentOver) {
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
      child: Text(
        'Extras',
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );

    // Create Extras List
    var extras = List<Widget>();
    for (var ball in _recentOverExtras) {
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
      height: 60.2,
      alignment: Alignment(0.0, 0.0),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '$_totalextras',
                textScaleFactor: 2,
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
              Text(
                'Total Extras',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '$_wides',
                textScaleFactor: 2,
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
              Text(
                'Wides',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '$_noBalls',
                textScaleFactor: 2,
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
              Text(
                'No Balls',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '$_legByes',
                textScaleFactor: 2,
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
              Text(
                'Leg Byes',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ],
          ),
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
          Text(
            'Batting',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          SizedBox(width: 25.0),
          new Container(
              child: Image(
            image: AssetImage("./assets/Bowler.png"),
            height: 94.0,
            width: 53.0,
          )),
          new FittedBox(
              child: Text(
            "Bowling",
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ))
        ],
      ),
    );

    final batsmanDetails = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            _batsmanOne,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          Text(
            _batsmanOneScore,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          Text(
            _batsmanTwo,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          Text(
            _batsmanTwoScore,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ],
      ),
    );

    final bowlerDetails = new Container(
      alignment: Alignment(1.0, 0.0),
      margin: EdgeInsets.only(left: 15.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            _bowler,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          Text(
            _bowlerScore,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          Text(
            _runrate,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
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
        child: Center(
          child: Text(
            _status,
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ));

    final summeryCard = new FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: new EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              const Color.fromRGBO(162, 32, 255, 0.2),
              const Color.fromRGBO(226, 7, 215, 0.2),
            ],
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(35.0)),
        ),
        child: new ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
      body: RefreshIndicator(
        onRefresh: updateState,
        child: Center(
          child: Container(
            color: Color.fromRGBO(15, 7, 85, 1),
            child: ListView(
              children: <Widget>[title, mainContainer],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0000).withOpacity(0.7),
        onPressed: _launchURL,
        tooltip: 'Live Stream',
        child: Icon(Icons.live_tv),
        elevation: 2.0,
      ),
    );
  }
}
