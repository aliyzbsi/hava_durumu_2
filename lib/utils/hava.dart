import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:hava_durumu_2/screens/main_screens.dart';

const apiKey = "bb15732e7f5a4e67955120243222306";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class HavaDurumuBilgisi {
  HavaDurumuBilgisi();
  late String sehir = "Elazığ";
  late double currentTemperature;
  late dynamic currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${sehir}&aqi=no"));

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['current']['temp_c'];
        currentCondition = currentWeather['current']['condition']['text'];
      } catch (e) {
        print(e);
      }
    } else {
      print("apiden değer gelmedi.");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    print("hava sıcaklığı $currentTemperature");
    print("hava durumu $currentCondition");
    if (currentCondition == "Sunny") {
      return WeatherDisplayData(
          weatherIcon:
              Icon(FontAwesomeIcons.sun, size: 75.0, color: Colors.white),
          weatherImage: AssetImage("assets/gunesli.jpg"));
    } else {
      if (currentCondition == "Partly cloudy") {
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.cloud, size: 75.0, color: Colors.white),
            weatherImage: AssetImage("assets/bulutlu1.jpg"));
      } else {
        if (currentCondition == "Moderate or heavy rain with thunder") {
          return WeatherDisplayData(
              weatherIcon: Icon(FontAwesomeIcons.rainbow,
                  size: 75.0, color: Colors.white),
              weatherImage: AssetImage("assets/yagmurlu.jpg"));
        } else {
          if (currentCondition == "Patchy rain possible") {
            return WeatherDisplayData(
                weatherIcon: Icon(FontAwesomeIcons.rainbow,
                    size: 75.0, color: Colors.white),
                weatherImage: AssetImage("assets/yagmurlu.jpg"));
          } else {
            return WeatherDisplayData(
                weatherIcon: Icon(FontAwesomeIcons.wind,
                    size: 75.0, color: Colors.white),
                weatherImage: AssetImage("assets/gece.jpg"));
          }
        }
      }
    }
  }
}
