import '../entities/seacrh_query.dart';
import '../entities/seacrh_response.dart';

abstract class JapaneseRepository<T extends SearchResponse> {
  Future<T> getKanjiInfo(SearchQuery query);
}