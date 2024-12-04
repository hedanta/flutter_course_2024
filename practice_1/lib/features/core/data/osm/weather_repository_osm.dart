import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOSM extends WeatherRepository<SearchResponse> {
  final OSMApi _api;

  WeatherRepositoryOSM(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    if (query is SearchQueryCity) {
      var response = await _api.getWeatherCity(query.city);
      return SearchResponse(response.temp.round().toInt(), _weatherType(response.type).toTypeString());
    } else if (query is SearchQueryCoord) {
      var response = await _api.getWeatherCoord(query.lat, query.long);
      return SearchResponse(response.temp.round().toInt(), _weatherType(response.type).toTypeString());
    } else {
      throw UnimplementedError('Метод данным API не поддерживается.');
    }
  }
}

WeatherType _weatherType(String type) {
  switch (type) {
    case 'Clouds':
      return WeatherType.cloudy;
    case 'Clear':
      return WeatherType.clear;
    case 'Rain':
      return WeatherType.rain;
    default:
      return WeatherType.other;
  }
}