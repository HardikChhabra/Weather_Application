import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_application/services/weather_model.dart';
import 'package:weather_application/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //apikey
  final _weatherService = WeatherService('c6f1eadd99c01d9a2d9ade9a5acc5bc7');
  Weather? _weather;

  //fetch weather
  fetchWeather() async {
    //get city name
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
     try {
       final weather = await _weatherService.getWeather(cityName);
       setState(() {
         _weather = weather;
       });
    }
    catch (e) {
       print(e);
    }
  }
  
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    //fetching the weather
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    Color appColor = Colors.black;
    return GestureDetector(
      onLongPress: () {
        print("Refreshing...");
        fetchWeather();
      },
      child: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //city name
              Text(
                _weather?.cityName ?? "Loading city...",
                style: GoogleFonts.teko(
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800
                  ),
                ),
              ),
              //animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              //weather condition
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _weather?.mainCondition ?? "Loading Condition...",
                    style: GoogleFonts.teko(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800
                      )
                    ),
                  ),
                  //weather
                  Text(
                    "${_weather?.temperature}°",
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800
                      )
                    ),
                  ),
                  Text(
                    "Long press to refresh",
                    style: GoogleFonts.teko(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
