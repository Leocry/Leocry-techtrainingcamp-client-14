import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // 地区
  String offset; //距离当地时间的差值
  String flag; //图标资源
  String url; //获得时间的url
  bool isDayTime; //判断是否为白天，用来设置背景等

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      //获得时区的数据json格式
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    //从中获取时间
    String datetime = data['datetime'];
    print(datetime);
    offset = data['utc_offset'].substring(0, 3);

    DateTime now = DateTime.parse(datetime);

    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime = now.hour > 6 && now.hour < 18 ? true : false;

    } catch (e) {
      print('error caught: $e');
      offset = null;
    }
  }
}

