import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_clock_and_alarm/add_alarm.dart';

import 'home.dart';
import 'package:ui_clock_and_alarm/choose_location.dart';
import 'package:ui_clock_and_alarm/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
  '/': (context) => Loading(),
  '/home': (context) => Home(),
  '/add-alarm': (context) => AddAlarm(),
  '/location': (context) => ChooseLocation(),
  },
));
