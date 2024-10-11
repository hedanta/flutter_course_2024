import 'package:practice_1/features/core/data/om/om_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOM implements WeatherRepository {
  final OMApi _api;

  WeatherRepositoryOM(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    if (query is SearchQueryCoord) {
      var response = await _api.getWeatherCoord(query.lat, query.long);
      return SearchResponse(response.temp.toInt(), _weatherType(response.type));
    } else {
      throw UnimplementedError('Метод данным API не поддерживается.');
    }
  }
}

WeatherType _weatherType(int code) {
  switch (code) {
    case 2 || 3:
      return WeatherType.cloudy;
    case 0 || 1:
      return WeatherType.clear;
    case 51 || 53 || 55 || 61 || 63 || 65:
      return WeatherType.rain;
    default:
      return WeatherType.other;
  }
}