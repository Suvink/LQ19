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
          textScaleFactor: 1.5,
          style: TextStyle(
              fontFamily: "Montserrat", color: Colors.white)),
    );

    final heading = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),)
      ),
      child: Table(
        children: [
          TableRow(
              children: [
                TableCell(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0,top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Container(
                            width: 75.0,
                            child: Text("Batsman",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontFamily: "Montserrat", color: Color(0xFF0F0755))),
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

    final scorecard = new Padding(
      padding: EdgeInsets.only(bottom: 5.0,top: 5.0),
      child: Container(
        color: Color(0xFFFFFFFF).withOpacity(0.2),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Container(
                      width: 65.0,
                      child: Text("Vishmitha",
                          textScaleFactor: 0.8,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,)),
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
        ),
      ),
    );



    final scorecard1 = new Padding(
      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
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
                      child: Text("Vishmitha",
                          textScaleFactor: 0.8,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,)),
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
        ),
      ),
    );




    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF0F0755),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title, heading, scorecard1,scorecard,scorecard1,scorecard],
          ),
        ),
      ),
    );
  }
}
