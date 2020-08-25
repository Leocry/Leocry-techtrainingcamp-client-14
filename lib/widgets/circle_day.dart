import 'package:flutter/material.dart';

Widget circleDay(day, context, selected){
  return Container(
    width: 40.0,
    height: 40.0,
    decoration: BoxDecoration(
      color: (selected)?Theme.of(context).accentColor:Colors.transparent,
      borderRadius: BorderRadius.circular(100.0)
    ),
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0
          ),
        ),
      ),
    )
  );
}