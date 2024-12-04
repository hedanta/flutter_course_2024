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
  final String weatherUrl;
  final String geoUrl;

  OMApi(this.weatherUrl, this.geoUrl);

  Future<OMWeather> getWeatherCoord(double lat, double long) async {
    var response = await http.get(Uri.parse('$weatherUrl'
        '/v1/forecast?latitude=$lat&longitude=$long'
        '&wind_speed_unit=ms'
        '&current=temperature_2m,weather_code,wind_speed_10m,is_day'
        '&daily=temperature_2m_max,temperature_2m_min&forecast_days=1'));
    if (response.statusCode == 404) {
      throw CityNotFoundException('Погода по координатам $lat, $long не найдена. '
                                  'Проверьте, что указаны верные координаты.');
    } else if (response.statusCode != 200) {
      throw Exception('Не удалось получить данные по координатам $lat, $long. '
                      'Код ошибки: ${response.statusCode}');
    }
    var rJson = jsonDecode(response.body);
    print(rJson);
    return OMWeather(rJson['current']['temperature_2m'],
                     rJson['current']['weather_code'],
                     rJson['current']['wind_speed_10m'],
                     rJson['current']['is_day'],
                     rJson['daily']['temperature_2m_min'][0],
                     rJson['daily']['temperature_2m_max'][0]);
  }

  Future<OMWeather> getWeatherCity(String city, [String language = 'en']) async {
    var coordsResponse = await http.get(Uri.parse('$geoUrl/v1/search?name=$city'
                                                '&language=$language&count=1'));
    var coordJson = jsonDecode(coordsResponse.body);
    if (coordJson.keys.length == 1 ||
        coordJson['results'][0]['name'].toString().toLowerCase() != city.toLowerCase()) {
      throw CityNotFoundException('Город $city не найден.');
    } else if (coordsResponse.statusCode != 200) {
      throw Exception('Не удалось получить данные для города $city. Код ошибки: ${coordsResponse.statusCode}');
    }
    double lat = coordJson['results'][0]['latitude'];
    double long = coordJson['results'][0]['longitude'];
    return getWeatherCoord(lat, long);
  }
}