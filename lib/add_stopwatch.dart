import 'package:flutter/material.dart';
import 'dart:async';

class AddStopWatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Stopwatch App',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Stopwatch watch = new Stopwatch();
  Timer timer;
  String passedTime = '00:00:00.00';

  updateTime(Timer timer) {
    if(mounted){
      setState(() {
        passedTime = transformTime(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
      child: new Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
              passedTime,
              style: new TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                  fontFamily: 'SourceSansPro',
                  decoration: TextDecoration.none
              ),
          ),
          SizedBox(height: 50.0),
          new Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 5.0),
              new IconButton(
                  onPressed: start,
                  color: Color(0xFF00FF00),
                  iconSize: 85,
                  icon: Icon(Icons.play_arrow),
              ),
              SizedBox(width: 20.0),
              new IconButton(
                  onPressed: stop,
                  color: Colors.red,
                  iconSize: 85,
                  icon: Icon(Icons.stop)),
              SizedBox(width: 20.0),
              new IconButton(
                  onPressed: reset,
                  color: Colors.yellow,
                  iconSize: 75,
                  icon: Icon(Icons.refresh),
              ),
            ],
          )
        ],
      ),
    );
  }

  start() {
    watch.start();
    timer = new Timer.periodic(new Duration(milliseconds: 30), updateTime);
  }

  stop() {
    watch.stop();
    updateTime(timer);
  }

  reset() {
    watch.reset();
    updateTime(timer);
  }

  transformTime(int millisecondsTime) {
    int milliseconds = (millisecondsTime%1000)~/10;
    int seconds = millisecondsTime~/1000;
    int minutes = seconds~/60;
    seconds = seconds-60*minutes;
    int hours = minutes~/60;
    minutes = minutes-60*hours;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String millisecondsStr = milliseconds.toString().padLeft(2, '0');
    String timeStr = '$hoursStr:$minutesStr:$secondsStr.$millisecondsStr';
    return timeStr;
  }
}
