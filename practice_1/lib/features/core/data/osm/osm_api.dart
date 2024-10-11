import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/osm/models/osm_weather.dart';

class CityNotFoundException implements Exception {
  final String message;
  CityNotFoundException(this.message);

  @override
  String toString() => 'CityNotFoundException: $message';
}

class OSMApi {
  final String url;
  final String apiKey;

  OSMApi(this.url, this.apiKey);

  Future<OSMWeather> getWeatherCity(String city) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?q=$city&appid=$apiKey'));
    if (response.statusCode == 404) {
      throw CityNotFoundException('Город $city не найден. Проверьте, что введено английское название.');
    } else if (response.statusCode != 200) {
      throw Exception('Не удалось получить данные для города $city. Код ошибки: ${response.statusCode}');
    }

    var rJson = jsonDecode(response.body);
    return OSMWeather(rJson['main']['temp']-273, rJson['weather'][0]['main']);
  }

  Future<OSMWeather> getWeatherCoord(double lat, double long) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey'));
    if (response.statusCode == 404) {
      throw CityNotFoundException('Погода по координатам $lat, $long не найдена. Проверьте, что указаны верные координаты.');
    } else if (response.statusCode != 200) {
      throw Exception('Не удалось получить данные по координатам $lat, $long. Код ошибки: ${response.statusCode}');
    }
    var rJson = jsonDecode(response.body);
    return OSMWeather(rJson['main']['temp']-273, rJson['weather'][0]['main']);
  }
}