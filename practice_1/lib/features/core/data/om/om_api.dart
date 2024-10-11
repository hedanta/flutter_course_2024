import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/om/models/om_weather.dart';

class CityNotFoundException implements Exception {
  final String message;
  CityNotFoundException(this.message);

  @override
  String toString() => 'CityNotFoundException: $message';
}

class OMApi {
  final String url;

  OMApi(this.url);

  Future<OMWeather> getWeatherCoord(double lat, double long) async {
    var response = await http.get(Uri.parse('$url/v1/forecast?latitude=$lat&longitude=$long&current=temperature_2m,weather_code'));
    if (response.statusCode == 404) {
      throw CityNotFoundException('Погода по координатам $lat, $long не найдена. Проверьте, что указаны верные координаты.');
    } else if (response.statusCode != 200) {
      throw Exception('Не удалось получить данные по координатам $lat, $long. Код ошибки: ${response.statusCode}');
    }
    var rJson = jsonDecode(response.body);
    return OMWeather(rJson['current']['temperature_2m'], rJson['current']['weather_code']);
  }
}