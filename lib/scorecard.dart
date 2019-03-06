import 'package:flutter/material.dart';

class scorecard extends StatefulWidget {
  @override
  _scorecardState createState() => _scorecardState();
}

class _scorecardState extends State<scorecard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: new Text("Richmond Live",
          style: TextStyle(
              fontSize: 24.0, fontFamily: "Montserrat", color: Colors.white)),
    );

    final heading = new Table(
      children: [
        TableRow(
            children: [
              TableCell(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Container(
                      width: 75.0,
                      child: Text("Batsman",
                          style: TextStyle(
                              fontFamily: "Montserrat", color: Colors.white)),
                    ),
                    new Text("R",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                    new Text("B",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                    new Text("M",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                    new Text("4s",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                    new Text("6s",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                    new Text("S/R",
                        style: TextStyle(
                            fontFamily: "Montserrat", color: Colors.white)),
                  ],
                ),
              ))
        ]),
      ],
    );

    final scorecard = new Table(
      children: [
        TableRow(children: [
          TableCell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 65.0,
                  child: Text("Vishmitha",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 11.0)),
                ),
                new Text("3",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("6",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("8",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("2",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("1",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
                new Text("117.0",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 11.0)),
              ],
            ),
          ),
        ]),
      ],
    );




    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF0F0755),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title, heading, scorecard,],
          ),
        ),
      ),
    );
  }
}
