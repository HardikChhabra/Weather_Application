import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:weather_application/pages/weather_page.dart';

/*added packages:
http
geolocator
geocoding
lottie (for animations)*/
void main() {
  Color navbarColor = Colors.black;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: navbarColor,
  ));
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherPage(),
  ));
}
