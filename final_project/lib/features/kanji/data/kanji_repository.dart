import 'package:final_project/features/kanji/domain/entities/kanji.dart';
import 'package:final_project/features/kanji/domain/repositories/japanese_repository.dart';
import 'package:final_project/features/kanji/data/data_sources/kanji_api.dart';

class KanjiRepository implements JapaneseRepository {
  final KanjiApi kanjiApi;

  KanjiRepository(this.kanjiApi);

  @override
  Future<Kanji> fetchKanjiInfo(String kanji) async {
    return await kanjiApi.fetchKanjiInfo(kanji);
  }
}