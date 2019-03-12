import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FullScoreCard extends StatefulWidget {
  final String scoreBoardAPI;
  const FullScoreCard({
    Key key,
    this.scoreBoardAPI,
  }) : super(key: key);

  @override
  _FullScoreCardState createState() => _FullScoreCardState();
}

class _FullScoreCardState extends State<FullScoreCard> {
  List richmondBattersState;
  List mahindaBattersState;
  bool _isLoading = true;
  bool _error = false;

  Future updateState() {
    return http.get(widget.scoreBoardAPI).then((http.Response response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (this.mounted) {
          setState(() {
            richmondBattersState = data['Richmond Batters'];
            mahindaBattersState = data['Mahinda Batters'];
            _isLoading = false;
          });
        }
      }
    }).catchError((e) {
      setState(() {
        _error = true;
      });
    });
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
                setState(() {
                  _isLoading = true;
                  _error = false;
                });
                updateState();
              },
              child: new Text("Try Again"),
            ),
          ],
        )),
      );
    }

    if (_isLoading) {
      return new Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: new Text("Richmond Live",
          textScaleFactor: 1.5,
          style: TextStyle(fontFamily: "Montserrat", color: Colors.white)),
    );

    final battingheading = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          )),
      child: Table(
        children: [
          TableRow(children: [
            TableCell(
                child: Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
                    width: 75.0,
                    child: Text("Batsman",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xFF0F0755))),
                  ),
                  new Text("R",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                  new Text("B",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                  new Text("M",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                  new Text("4s",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                  new Text("6s",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                  new Text("S/R",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                ],
              ),
            ))
          ]),
        ],
      ),
    );

    var richmondBatters = List<Widget>();
    richmondBatters.add(Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text("Richmond College", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,textScaleFactor: 1.2),
    ));
    richmondBatters.add(battingheading);
    for (var player in richmondBattersState) {
      richmondBatters.add(
        new BattingFullScoreCard(
          name: player['name'],
          runs: player['runs'],
          m: player['m'],
          fours: player['4s'],
          sixes: player['6s'],
          sr: player['s/r'],
          balls: player['balls'],
        ),
      );
    }

    var mahindaBatters = List<Widget>();
    richmondBatters.add(Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: Text("Mahinda College", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,textScaleFactor: 1.2),
    ));

    mahindaBatters.add(battingheading);
    for (var player in mahindaBattersState) {
      mahindaBatters.add(
        new BattingFullScoreCard(
          name: player['name'],
          runs: player['runs'],
          m: player['m'],
          fours: player['4s'],
          sixes: player['6s'],
          sr: player['s/r'],
          balls: player['balls'],
        ),
      );
    }

    //Bowling head
    final bowlingheading = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          )),
      child: Table(
        children: [
          TableRow(children: [
            TableCell(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        width: 75.0,
                        child: Text("Bowler",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color(0xFF0F0755))),
                      ),
                      new Text("O",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                      new Text("M",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                      new Text("R",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                      new Text("W",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Color(0xFF0F0755))),
                      new Text("Econ",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Color(0xFF0F0755)))
                    ],
                  ),
                ))
          ]),
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
            children: <Widget>[
              title,
              ListView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: richmondBatters,
              ),
              ListView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: mahindaBatters,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BattingFullScoreCard extends StatelessWidget {
  const BattingFullScoreCard({
    Key key,
    this.name,
    this.runs,
    this.balls,
    this.m,
    this.fours,
    this.sixes,
    this.sr,
  }) : super(key: key);

  final String name;
  final String runs;
  final String balls;
  final String m;
  final String fours;
  final String sixes;
  final String sr;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        color: Color(0xFFFFFFFF).withOpacity(0.0),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Container(
                      width: 65.0,
                      child: Text("$name",
                          textScaleFactor: 0.8,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                          )),
                    ),
                    new Text("$runs",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                    new Text("$balls",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                    new Text("$m",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                    new Text("$fours",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                    new Text("$sixes",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                    new Text("$sr",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 11.0)),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}




final bowlerrr = new Padding(
  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
  child: Container(
    color: Color(0xFFFFFFFF).withOpacity(0.0),
    child: Table(
      children: [
        TableRow(children: [
          TableCell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 65.0,
                  child: Text("Charith",
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      )),
                ),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
              ],
            ),
          ),
        ]),
      ],
    ),
  ),
);