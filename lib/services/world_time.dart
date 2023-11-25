import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name
  String flag; // flag icon
  String url; // url for API endpoint
  late String time; // time in location
  late bool isDaytime;

  WorldTime({required this.flag, required this.location, required this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 7 && now.hour < 21 ? true : false;
      print(isDaytime);
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could no get data';
    }
  }
}
