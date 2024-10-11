import 'dart:ffi';

import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print('Введите город или координаты (через пробел)');
    var input = stdin.readLineSync();

    if (input == null) {
      print('Ошибка ввода');
      return;
    }

    input = input.trim();
    if (input.contains(' ')) {
      var coords = input.split(' ');
      var lat = double.tryParse(coords[0]);
      var long = double.tryParse(coords[1]);

      if (coords.length != 2 || lat == null || long == null) {
        print ('Неправильный формат координат');
        return;
      }

      var resp = await repository.getWeather(SearchQueryCoord(lat, long));
      print('Погода по координатам $lat, $long: ${resp.temp} градусов по Цельсию, тип: ${resp.type}');
    } else {
      var city = input;

      var resp = await repository.getWeather(SearchQueryCity(city));
      print('Погода в городе $city: ${resp.temp} градусов по Цельсию, тип: ${resp.type}');
    }
  }
}