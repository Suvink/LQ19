import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'score_ball.dart';
import 'scorecard.dart';

class LiveScores extends StatefulWidget {
  final Map<String, dynamic> initdata;

  const LiveScores({
    Key key,
    this.initdata,
  }) : super(key: key);

  @override
  _LiveScoreState createState() => _LiveScoreState();
}

class _LiveScoreState extends State<LiveScores> {
  String _scoreAPI;
  String _fullScoreCardAPI;
  String _streamURL;
  String _crest;
  String _score;
  String _overs;
  String _status;
  String _batsmanOne;
  String _batsmanTwo;
  String _bowler;
  String _runrate;
  // String _battingTeam;
  String _batsmanOneScore;
  String _batsmanTwoScore;
  String _bowlerScore;
  List _recentOver;
  List _recentOverExtras;
  int _totalextras;
  int _noBalls;
  int _wides;
  int _legByes;
  bool _isLoading = true;
  bool _error = false;

  Future updateState() async {
    return http
        .get(
            "https://raw.githubusercontent.com/Suvink/MekaJsonEkak/master/main.json")
        .then((http.Response response) {
      Map<String, dynamic> apis = json.decode(response.body);
      _streamURL = apis['streamURL'];
      _scoreAPI = apis['scoreAPI'];
      _fullScoreCardAPI = apis['scoreoardAPI'];
      http.get(_scoreAPI).then((http.Response response) {
        Map<String, dynamic> data = json.decode(response.body);
        if (this.mounted) {
          setState(() {
            _crest = data['crest'];
            _score = data['score'];
            _overs = data['overs'];
            _status = data['string'];
            _batsmanOne = data['batsmanOne']['name'];
            _batsmanTwo = data['batsmanTwo']['name'];
            _bowler = data['bowler']['name'];
            _runrate = data['runRate'];
            // _battingTeam = data['battingTeam'];
            _batsmanOneScore = data['batsmanOne']['runs'];
            _batsmanTwoScore = data['batsmanTwo']['runs'];
            _bowlerScore = data['bowler']['figures'];
            _totalextras = data['extras']['totalExtras'];
            _noBalls = data['extras']['noBalls'];
            _wides = data['extras']['wides'];
            _legByes = data['extras']['legByes'];
            _recentOver = data['recentOver'][0];
            _recentOverExtras = data['recentOver'][1];
            _streamURL = data['streamURL'];
            _isLoading = false;
          });
        }
      }).catchError((e) {
        if (this.mounted) {
          setState(() {
            _error = true;
          });
        }
      });
    }).catchError((e) {
      if (this.mounted) {
        setState(() {
          _error = true;
        });
      }
    });
  }

  //Youtube launch function
  _launchURL() async {
    if (await canLaunch(_streamURL)) {
      await launch(_streamURL);
    }
    // else {
    //   throw 'Could not launch live stream! Please check your connection!';
    // }
  }

  @override
  Widget build(BuildContext context) {
    updateState();

    if (_error) {
      return new Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Oops! Something went wrong!',
              textScaleFactor: 2,
              textAlign: TextAlign.center,
            ),
            Text(
              'Please make sure you have an active internet connection!',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Color(0xFF300e57),
              onPressed: () {
                if (this.mounted) {
                  setState(() {
                    _isLoading = true;
                    _error = false;
                  });
                }
                updateState();
              },
              child: new Text("Try Again"),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF300e57).withOpacity(0.7),
          onPressed: _launchURL,
          tooltip: 'Live Stream',
          child: Icon(Icons.live_tv),
          elevation: 2.0,
        ),
      );
    }

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
    final title = Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        "Richmond Live",
        textScaleFactor: 1.5,
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
    );

    //Logo
    final crest = Center(
      child: Image(
        image: AssetImage('assets/' + _crest),
        height: 79.0,
        width: 64.0,
      ),
    );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(
        _score,
        textScaleFactor: 4,
        style: TextStyle(color: Color(0xFF404040)),
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
        style: TextStyle(color: Color(0xFF404040)),
      ),
    );

    //This Over Title
    final thisOverTitle = Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment(0.0, 0.0),
        child: Text(
          'This Over',
          style: TextStyle(color: Color(0xFF404040)),
        ));

    // Create Ball List
    var thisOver = List<Widget>();
    for (var ball in _recentOver) {
      thisOver.add(new ScoreBall(score: ball));
    }

    //Scoreballs Wrapper
    final scoreballsSet = Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: thisOver),
    );

    //Extras Title
    // final extrasTitle = Container(
    //   margin: EdgeInsets.only(top: 5.0),
    //   alignment: Alignment(0.0, 0.0),
    //   child: Text(
    //     'Extras',
    //     style: TextStyle(color: Color(0xFF404040)),
    //   ),
    // );

    // Create Extras List
    var extras = List<Widget>();
    for (var ball in _recentOverExtras) {
      extras.add(new ScoreBall(score: ball));
    }

    //Extras Wrapper
    // final extrasSet = Container(
    //   alignment: Alignment(0.0, 0.0),
    //   margin: EdgeInsets.only(top: 7.0),
    //   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: extras),
    // );

    final totalextras = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 60.2,
      alignment: Alignment(0.0, 0.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '$_totalextras',
                textScaleFactor: 2,
                style: TextStyle(color: Color(0xFF404040)),
              ),
              Text(
                'Total Extras',
                style: TextStyle(color: Color(0xFF404040)),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            children: <Widget>[
              Text(
                '$_wides',
                textScaleFactor: 2,
                style: TextStyle(color: Color(0xFF404040)),
              ),
              Text(
                'Wides',
                style: TextStyle(color: Color(0xFF404040)),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            children: <Widget>[
              Text(
                '$_noBalls',
                textScaleFactor: 2,
                style: TextStyle(color: Color(0xFF404040)),
              ),
              Text(
                'No Balls',
                style: TextStyle(color: Color(0xFF404040)),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            children: <Widget>[
              Text(
                '$_legByes',
                textScaleFactor: 2,
                style: TextStyle(color: Color(0xFF404040)),
              ),
              Text(
                'Leg Byes',
                style: TextStyle(color: Color(0xFF404040)),
              ),
            ],
          ),
        ],
      ),
    );

    //Batsman and Bowler details
    final bottomTitleSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage("./assets/batsman.png"),
              height: 94.0,
              width: 53.0,
            ),
          ),
          Text(
            'Batting',
            textScaleFactor: 1.7,
            style: TextStyle(
              color: Color(0xFF404040),
            ),
          ),
          SizedBox(width: 25.0),
          Container(
              child: Image(
            image: AssetImage("./assets/Bowler.png"),
            height: 94.0,
            width: 53.0,
          )),
          FittedBox(
              child: Text(
            "Bowling",
            textScaleFactor: 1.7,
            style: TextStyle(color: Color(0xFF404040)),
          ))
        ],
      ),
    );

    final batsmanDetails = Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            _batsmanOne,
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            _batsmanOneScore,
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            _batsmanTwo,
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            _batsmanTwoScore,
            style: TextStyle(color: Color(0xFF404040)),
          ),
        ],
      ),
    );

    final bowlerDetails = Container(
      alignment: Alignment(1.0, 0.0),
      margin: EdgeInsets.only(left: 15.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            _bowler,
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            _bowlerScore,
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            'Run Rate',
            style: TextStyle(color: Color(0xFF404040)),
          ),
          Text(
            _runrate,
            style: TextStyle(color: Color(0xFF404040)),
          ),
        ],
      ),
    );

    //Batsman and Bowler Wrapper
    final batsmanandbowler = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[batsmanDetails, bowlerDetails],
    );

    //Line separator
    final lineSeperator = Container(
      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
      height: 2.0,
      color: Color(0xFFBCB8B8),
    );

    //StatusBar
    final statusBar = Container(
        margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 25.0),
        child: Center(
          child: Text(
            _status,
            style: TextStyle(color: Color(0xFF404040)),
          ),
        ));

    final summeryCard = FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            crest,
            score,
            overs,
            thisOverTitle,
            scoreballsSet,
            //extrasTitle,
            //extrasSet,
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
    final mainContainer = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScoreCard(
                        scoreBoardAPI: _fullScoreCardAPI,
                      )));
        },
        child: summeryCard);

    return Scaffold(
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
        backgroundColor: Color(0xFF300e57).withOpacity(0.7),
        onPressed: _launchURL,
        tooltip: 'Live Stream',
        child: Icon(Icons.live_tv),
        elevation: 2.0,
      ),
    );
  }
}
