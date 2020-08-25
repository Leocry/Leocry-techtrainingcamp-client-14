import 'package:flutter/material.dart';
import 'dart:async';

class AddTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Timer App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
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
  int totalMilliseconds = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  double _hoursDouble = 0.0;
  double _minutesDouble = 0.0;
  double _secondsDouble = 0.0;
  String remainingTime = '00:00:00';

  updateTime(Timer timer) {
    setState(() {
      totalMilliseconds = 3600*1000*hours+60*1000*minutes+1000*seconds;
      remainingTime = transformTime(totalMilliseconds-watch.elapsedMilliseconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*new Scaffold(
        backgroundColor: Color(0xff1B2C57),
        body: */
    new Padding(
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 100.0),
            new Text(
              remainingTime,
              style: new TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                  decoration: TextDecoration.none
              ),
            ),
            SizedBox(height: 40.0),
            new Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20.0),
                new IconButton(
                    onPressed: start,
                    color: Color(0xFF00FF00),
                    iconSize: 75,
                    icon: Icon(Icons.play_arrow)),
                SizedBox(width: 20.0),

                new IconButton(
                    onPressed: stop,
                    color: Colors.red,
                    iconSize: 75,
                    icon: Icon(Icons.stop)),

                SizedBox(width: 20.0),
                new IconButton(
                  onPressed: reset,
                  color: Colors.yellow,
                  iconSize: 65,
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            new Slider(
              value: _hoursDouble,
              label: 'Hours: ${_hoursDouble.toInt()}',
              min: 0.0,
              max: 23.0,
              divisions: 100,
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.white,
              onChanged: (val){
                setState(() {
                  _hoursDouble = val;
                  hours = _hoursDouble.toInt();
                  updateTime(timer);
                });
              },
            ),
            new Slider(
              value: _minutesDouble,
              label: 'Minutes: ${_minutesDouble.toInt()}',
              min: 0.0,
              max: 59.0,
              divisions: 100,
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.white,
              onChanged: (val){
                setState(() {
                  _minutesDouble = val;
                  minutes = _minutesDouble.toInt();
                  updateTime(timer);
                });
              },
            ),
            new Slider(
              value: _secondsDouble,
              label: 'Seconds: ${_secondsDouble.toInt()}',
              min: 0.0,
              max: 59.0,
              divisions: 100,
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.white,
              onChanged: (val){
                setState(() {
                  _secondsDouble = val;
                  seconds = _secondsDouble.toInt();
                  updateTime(timer);
                });
              },
            ),
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
    if (millisecondsTime > 0) {
      int seconds = millisecondsTime ~/ 1000;
      int minutes = seconds ~/ 60;
      seconds = seconds - 60 * minutes;
      int hours = minutes ~/ 60;
      minutes = minutes - 60 * hours;
      String hoursStr = hours.toString().padLeft(2, '0');
      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondsStr = seconds.toString().padLeft(2, '0');
      String timeStr = '$hoursStr:$minutesStr:$secondsStr';
      return timeStr;
    }
    else{
      return 'Time out!';
    }
  }
}