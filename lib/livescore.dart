import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class livescores extends StatefulWidget {
  @override
  _LivescoreState createState() => _LivescoreState();
}

class _LivescoreState extends State<livescores> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Title
    final title = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: new EdgeInsets.only(
        top: 5.0,
      ),
      child: new Text("Richmond Live",
          style: TextStyle(
              fontSize: 24.0, fontFamily: "Montserrat", color: Colors.white)),
    );

/*
    final bla = new Shimmer.fromColors(
        child: new Text("Hello asdma csfn fkjawfmak fwfmw"),
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        direction: ShimmerDirection.ltr,
    );
*/

    //Logo
    final crest = new Center(
      child: Image(
        image: AssetImage("./assets/crest_rcg.png"),
        height: 79.0,
        width: 64.0,
      ),
    );

    //Main Score
    final score = Container(
      margin: EdgeInsets.only(bottom: 0.0),
      padding: EdgeInsets.only(bottom: 0.0),
      alignment: Alignment(0.0, 0.0),
      child:
          Text("144/4", style: TextStyle(fontSize: 72.0, color: Colors.white)),
    );

    //Overs count
    final overs = Container(
      padding: EdgeInsets.only(bottom: 0.0),
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment(0.0, 0.0),
      child: Text("32.2 Overs",
          style: TextStyle(fontSize: 24.0, color: Color(0xFFB4B4B4))),
    );

    //This Over Title
    final thisOverTitle = new Container(
      alignment: Alignment(0.0, 0.0),
      child: Text(
        "This Over",
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
    );

    final scoreball = new Container(
      padding: EdgeInsets.only(top: 5.0),
      width: 26.0,
      height: 26.0,
      margin: EdgeInsets.only(left: 5.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(1.0),
            const Color(0xFFE207D7).withOpacity(1.0)
          ],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
      ),
      child: new Text(
        "1",
        style: TextStyle(fontSize: 13.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

    //Scoreballs Wrapper
    final scoreballsSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          scoreball,
          scoreball,
          scoreball,
          scoreball,
          scoreball,
          scoreball
        ],
      ),
    );

    //Extras Title
    final extrasTitle = new Container(
      margin: EdgeInsets.only(top: 5.0),
      alignment: Alignment(0.0, 0.0),
      child: Text(
        "Extras",
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
    );

    //Extras Wrapper
    final extrasSet = new Container(
      alignment: Alignment(0.0, 0.0),
      margin: EdgeInsets.only(top: 7.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          scoreball,
          scoreball,
          scoreball,
          scoreball,
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
          Text(
            "4\nTotal Extras",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "2\n Wides",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "0\n No Balls",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 15.0),
          Text(
            "1\n Leg Bys",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
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
              image: AssetImage("./assets/Bowler.png"),
              height: 94.0,
              width: 53.0,
            ),
          ),
          new Container(
              child: new Shimmer.fromColors(
                  child: Text(
                    "Bowling",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey)),
          SizedBox(width: 25.0),
          new Container(
              child: Shimmer(
            child: Image(
              image: AssetImage("./assets/batsman.png"),
              height: 94.0,
              width: 53.0,
            ),
            gradient: new LinearGradient(
              colors: [const Color(0xFFA220FF), const Color(0xFFE207D7)],
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
            ),
            direction: ShimmerDirection.ttb,
          )),
          new Container(
              child: new Shimmer.fromColors(
                  child: Text(
                    "Batting",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey)),
        ],
      ),
    );

    final bowlerDetails = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
        children: <Widget>[
          new Container(
              child: Text(
            "Charith Asalanka*",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "53(12)",
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              )),
          new Container(
              child: Text(
            "Charith Asalanka",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
          new Container(
              child: Text(
            "53(12)",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
        ],
      ),
    );

    final batsmanDetails = new Container(
      alignment: Alignment(1.0, 0.0),
      margin: EdgeInsets.only(left: 30.0, right: 10.0),
      child: Column(
        children: <Widget>[
          new Container(
              child: Text(
            "Charith Asalanka*",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
          new Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "53(12)",
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              )),
          new Container(
              child: Text(
            "Charith Asalanka",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
          new Container(
              child: Text(
            "53(12)",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )),
        ],
      ),
    );

    //Batsman and Bowler Wrapper
    final batsmanandbowler = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[bowlerDetails, batsmanDetails],
    );

    //Line seperator
    final lineSeperator = new Container(
      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
      height: 2.0,
      color: Color(0xFFBCB8B8),
    );

    //StatusBar
    final statusBar = new Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Shimmer.fromColors(
            child: Text("Richmond College won the toss and elected to bat first", style: TextStyle(fontSize: 12.0),),
            baseColor: Colors.white,
            highlightColor: Colors.grey)
    );

    //YouTube FAB
    /*
    final youtubeBtn = new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.check),
        backgroundColor: Colors.red,
        onPressed: (){}
    );
    */

    //Main Container
    final mainContainer = new Container(
      width: 348.0,
      margin: new EdgeInsets.all(13.0),
      padding: EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(0.22),
            const Color(0xFFE207D7).withOpacity(0.24)
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
        ],
      ),
    );

    final bottomContainer = new Container(
      height: 253.0,
      width: 348.0,
      margin: new EdgeInsets.all(13.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFA220FF).withOpacity(0.22),
            const Color(0xFFE207D7).withOpacity(0.24)
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
    );

    return new Scaffold(
      body: Center(
        child: Container(
          color: Color(0xFF0F0755),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[title, mainContainer, bottomContainer],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE207D7).withOpacity(0.7),
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
  const url = 'https://www.youtube.com/watch?v=vWfjlIMiqBg';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch live stream! Check Your connection!';
  }
}
