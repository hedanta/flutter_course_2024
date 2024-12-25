

import 'package:final_project/features/kanji/domain/entities/seacrh_query.dart';
import 'package:final_project/features/kanji/domain/entities/seacrh_response.dart';
import 'package:final_project/features/kanji/domain/repositories/japanese_repository.dart';

import 'kanji_api.dart';
import 'models/kanji.dart';

class KanjiRepository extends JapaneseRepository<SearchResponseKanjiapi> {
  final KanjiApi _api;

  KanjiRepository(this._api);

  @override
  Future<SearchResponseKanjiapi> getKanjiInfo(SearchQuery query) async {
    Kanji resp;
    resp = await _api.getKanjiInfo(query.kanji);
    return SearchResponseKanjiapi(
        resp.kanji,
        resp.heiseg,
        resp.meanings,
        resp.kunReadings,
        resp.onReadings,
        resp.jlpt);
  }


}