import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'live_score.dart';

class SplashScreen extends StatefulWidget {
  static String splash = "splash";

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  CurvedAnimation _iconAnimation;

  String streamURL;
  String scoreAPI;
  String highlightsAPI;

  Future<http.Response> _fetchAPIList() {
    return http.get(
        "https://raw.githubusercontent.com/Suvink/MekaJsonEkak/master/main.json");
  }

  void openLiveScoreCard(data) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => new LiveScores(
              initdata: data,
            )));
  }

  Future<http.Response> _fetchdata() async {
    http.Response res = await _fetchAPIList();
    Map<String, dynamic> apis = json.decode(res.body);
    streamURL = apis['streamURL'];
    scoreAPI = apis['scoreAPI'];
    highlightsAPI = apis['highlightsAPI'];

    return http.get(apis['scoreAPI']);
  }

  @override
  void initState() {
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3000));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new FutureBuilder(
            future: _fetchdata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return loadingAnimation();
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return loadingAnimation(error: snapshot.error);
                  Map<String, dynamic> data = json.decode(snapshot.data.body);
                  data['streamURL'] = streamURL;
                  data['scoreAPI'] = scoreAPI;
                  data['highlightsAPI'] = highlightsAPI;

                  openLiveScoreCard(data);
                  return loadingAnimation(
                      error: "This Should be Loaded by Now, Try Restarting");
              }
              return null;
            }));
  }
}

Widget loadingAnimation({String error}) {
  Widget _animation;
  if (error == null) {
    _animation = Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Text(
            "We are setting things up!",
            softWrap: true,
            textAlign: TextAlign.center,
            textScaleFactor: 2,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  } else {
    _animation = Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Something went wrong",
            softWrap: true,
            textAlign: TextAlign.center,
            textScaleFactor: 2,
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Text(
            "$error",
            softWrap: true,
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(color: Color(0xFF300e57)),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform(
                    alignment: Alignment(0.0, 0.0),
                    transform: new Matrix4.identity()..scale(0.5),
                    child: Image(image: AssetImage("assets/live.png")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                ],
              ),
            ),
          ),
          _animation
        ],
      )
    ],
  );
}
