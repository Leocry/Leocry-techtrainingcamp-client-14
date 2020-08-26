import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ui_clock_and_alarm/shapes_painter.dart';
import 'package:ui_clock_and_alarm/add_stopwatch.dart';
import 'package:ui_clock_and_alarm/add_timer.dart';


import 'add_stopwatch.dart';
import 'add_timer.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  Map data = {};
  String _timeString;
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    _timeString = _formatDateTime(DateTime.now());

   Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

   @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  void _getTime(){

    DateTime now = DateTime.now();
    now = now.add(Duration(hours: int.parse(data['offset'])-8));
    final String formattedDateTime = _formatDateTime(now);
    if(now.hour>=6 && now.hour<=18)
      data['isDayTime'] = true;
    else
      data['isDayTime'] = false;
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.Hms().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    //set background
    //留作改天气
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Color(0xff1B2C57);
    Color indiColor = data['isDayTime'] ? Colors.white : Color(0xff65D1BA);

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Container(
              padding: EdgeInsets.only(top:30),
              color: bgColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: indiColor,
                indicatorWeight: 3.0,
                tabs: [
                  Tab(icon: Icon(Icons.access_time), text: 'Clock',),
                 // Tab(icon: Icon(Icons.alarm), text: 'Alarm'),
                  Tab(icon: Icon(Icons.hourglass_empty), text: 'Timer'),
                  Tab(icon: Icon(Icons.timer), text: 'Stopwatch'),
//                  Tab(icon: Icon(Icons.language), text: 'World Clock'),
                ],
              ),
            ),
          ),
          body: Container(
            color: bgColor,
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 60.0, 0, 0),
                      ),
                      FlatButton.icon(
                          onPressed: () async {
                            dynamic result = await Navigator.pushNamed(context, '/location');
                            setState(() {
                              data = {
                                'offset': result['offset'],
                                'location': result['location'],
                                'isDayTime': result['isDayTime'],
                                'flag': result['flag']
                              };
                            });
                          },
                          icon: Icon(
                              Icons.edit_location,
                              color: Colors.grey[300]),
                          label: Text(
                              'Edit Location',
                              style: TextStyle(
                                  color: Colors.grey[300]
                              )
                          )
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data['location'],
                            style: TextStyle(
                                fontSize: 28.0,
                                letterSpacing: 2.0,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:40.0,horizontal:100.0),
                        child: CustomPaint(
                          painter: ShapesPainter(offset: data['offset']),
                          child: Container(height: 150,),
                        ),
                      ),                   
                      Text(_timeString.toString(), style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceSansPro'
                      ),)
                    ],
                  ),
                ),
               /* Container(
                  child: ListView(
                    children: <Widget>[
                      alarmItem(_timeString,true),
                      alarmItem(_timeString,true),
                      alarmItem(_timeString,false),
                      alarmItem(_timeString,false),
                    ],
                  ),
                ),
                //Icon(Icons.hourglass_empty),*/
                Container(
                    child: AddTimer(),
                    ),
                Container(
                    child: AddStopWatch(),
                ),//Icon(Icons.timer),
//                Icon(Icons.language),
              ],
            ),
          ),
        ),
      );
  }

  /*Widget _bottomButtons() {
    return _tabController.index == 1
      ?FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context,
            '/add-alarm'
        ), 
        backgroundColor: Color(0xff65D1BA),
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      )
      :null;
  }*/
}