import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HighLights extends StatefulWidget {
  final String highlightsAPI;
  const HighLights({
    Key key,
    this.highlightsAPI,
  }) : super(key: key);

  @override
  _HighLightsState createState() => _HighLightsState();
}

class _HighLightsState extends State<HighLights> {
  List _updates;
  bool _isLoading = true;

  Future<Null> updateState() {
    return http.get(widget.highlightsAPI).then((http.Response response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (this.mounted) {
          setState(() {
            _updates = data['updates'];
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateState();

    if (_isLoading) {
      return new Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var events = List<Widget>();
    for (var update in _updates) {
      events.add(new UpdateCard(
          day: update['day'],
          session: update['session'],
          time: update['time'],
          title: update['title'],
          description: update['description']));
    }

    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(top: 10.0),
      child: Text(
        "Updates",
        textScaleFactor: 1.5,
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
    );

    //Main Container
    final mainContainer = new GestureDetector(
      child: new Container(
        width: 348.0,
        margin: new EdgeInsets.all(13.0),
        padding: EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [const Color(0xFFFFFFFF), const Color(0xFFFFFFFF)],
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(35.0)),
        ),
        child: new ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: events,
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
            children: <Widget>[title, mainContainer],
          ),
        ),
      ),
    );
  }
}

class UpdateCard extends StatelessWidget {
  const UpdateCard({
    Key key,
    this.day,
    this.session,
    this.time,
    this.title,
    this.description,
  }) : super(key: key);

  final String day;
  final String session;
  final String time;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                'Day $day',
                textScaleFactor: 1.2,
                style: TextStyle(
                    fontFamily: "Montserrat", color: Color(0xFF404040)),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(title,
                    textScaleFactor: 2,
                    style: TextStyle(fontFamily: "Montserrat"),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                  child: Text(
                '$time',
                textScaleFactor: 1.2,
                style: TextStyle(
                    fontFamily: "Montserrat", color: Color(0xFF404040)),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        Text(description,
            style:
                TextStyle(fontFamily: "Montserrat", color: Color(0xFF404040))),
        Container(
          margin:
              EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
          height: 2.0,
          color: Color(0xFF404040),
        )
      ],
    );
  }
}
