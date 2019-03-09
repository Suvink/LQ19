import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<ScoreSummary> fetchSummary(String url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return ScoreSummary.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to Fetch Data from the Server');
  }
}

class ScoreSummary {
  final String crest;
  final String score;
  final String overs;
  final String status;
  final String batsmanOne;
  final String batsmanTwo;
  final String bowler;
  final String runrate;
  final String battingTeam;
  final String batsmanOneScore;
  final String batsmanTwoScore;
  final String bowlerScore;
  final int totalextras;
  final int noBalls;
  final int wides;
  final int legByes;
  final String lastWicket;
  final List recentOver;

  ScoreSummary({
    this.crest,
    this.score,
    this.overs,
    this.status,
    this.batsmanOne,
    this.batsmanTwo,
    this.bowler,
    this.runrate,
    this.battingTeam,
    this.batsmanOneScore,
    this.batsmanTwoScore,
    this.bowlerScore,
    this.totalextras,
    this.noBalls,
    this.wides,
    this.legByes,
    this.lastWicket,
    this.recentOver,
  });

  factory ScoreSummary.fromJson(Map<String, dynamic> json) {
    return ScoreSummary(
        crest: json['crest'],
        score: json['score'],
        overs: json['overs'],
        status: json['string'],
        batsmanOne: json['batsmanOne']['name'],
        batsmanTwo: json['batsmanTwo']['name'],
        bowler: json['bowler']['name'],
        runrate: json['runRate'],
        battingTeam: json['battingTeam'],
        batsmanOneScore: json['batsmanOne']['runs'],
        batsmanTwoScore: json['batsmanTwo']['runs'],
        bowlerScore: json['bowler']['figures'],
        totalextras: json['extras']['totalExtras'],
        noBalls: json['extras']['noBalls'],
        wides: json['extras']['wides'],
        legByes: json['extras']['legByes'],
        lastWicket: json['lastWicket'],
        recentOver: json['recentOver']);
  }
}
