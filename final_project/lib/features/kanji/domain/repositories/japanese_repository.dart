import 'package:final_project/features/kanji/domain/entities/kanji.dart';

abstract class JapaneseRepository {
  Future<Kanji> fetchKanjiInfo(String kanji);
}