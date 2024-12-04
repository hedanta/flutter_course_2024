import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';

abstract class WeatherRepository<T extends SearchResponse> {
  Future<T> getWeather(SearchQuery query);
}
