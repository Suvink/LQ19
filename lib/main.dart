import 'package:flutter/material.dart';
import 'livescore.dart';
import 'teamRcg.dart';
import 'teamMcg.dart';
import 'highlights.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //Define the backfround colour for the app : Blue
  MaterialColor backgroundColor = MaterialColor(0xFF0F0755, <int, Color>{
    50: Color(0xFFA4A4BF),
    100: Color(0xFFA4A4BF),
    200: Color(0xFFA4A4BF),
    300: Color(0xFF9191B3),
    400: Color(0xFF7F7FA6),
    500: Color(0xFF181861),
    600: Color(0xFF6D6D99),
    700: Color(0xFF5B5B8D),
    800: Color(0xFF494980),
    900: Color(0xFF181861),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Richmond Live',
      theme: ThemeData(
        fontFamily: "Montserrat",
        primaryColor: Colors.white,
        primarySwatch: backgroundColor,
      ),
      home: livescores(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Richmond Live"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
