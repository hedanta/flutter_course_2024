import 'package:practice_1/features/core/data/om/models/om_weather.dart';
import 'package:practice_1/features/core/data/om/om_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOM extends WeatherRepository<SearchResponseOM> {
  final OMApi _api;

  WeatherRepositoryOM(this._api);

  @override
  Future<SearchResponseOM> getWeather(SearchQuery query) async {
    OMWeather response;
    if (query is SearchQueryCity) {
      response = await _api.getWeatherCity(query.city, query.language);
    } else if (query is SearchQueryCoord) {
      response = await _api.getWeatherCoord(query.lat, query.long);
    } else {
      throw UnimplementedError('Метод данным API не поддерживается.');
    }

    return SearchResponseOM(response.temp.round().toInt(),
        _weatherType(response.type).toTypeString(),
        response.windSpeed.round().toInt(),
        (response.isDay).toInt(),
        response.minTemp.round().toInt(),
        response.maxTemp.round().toInt());
  }
}

WeatherType _weatherType(int code) {
  switch (code) {
    case 2 || 3:
      return WeatherType.cloudy;
    case 0 || 1:
      return WeatherType.clear;
    case 51 || 53 || 55 || 56 || 57 || 61 || 63 || 65 || 80 || 81 || 82:
      return WeatherType.rain;
    case 71 || 73 || 75 || 77 || 85 || 86:
      return WeatherType.snow;
    case 45 || 48:
      return WeatherType.fog;
    case 95 || 96 || 99:
      return WeatherType.thunderstorm;
    default:
      return WeatherType.other;
  }
}
