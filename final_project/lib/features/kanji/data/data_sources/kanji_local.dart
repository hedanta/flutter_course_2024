import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:final_project/features/kanji/domain/entities/kanji.dart';
import 'package:final_project/features/kanji/data/kanji_dto.dart';

class KanjiLocalDataSource {
  static const String _starredKanjisKey = 'starred_kanjis';

  Future<void> saveStarredKanji(Kanji kanji) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    starredKanjis.add(jsonEncode(KanjiDto.toJson(kanji)));
    await prefs.setStringList(_starredKanjisKey, starredKanjis);
  }

  Future<void> deleteStarredKanji(Kanji kanji) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    starredKanjis.removeWhere((item) => KanjiDto.fromJson(jsonDecode(item)).kanji == kanji.kanji);
    await prefs.setStringList(_starredKanjisKey, starredKanjis);
  }

  Future<List<Kanji>> getStarredKanjis() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    return starredKanjis.map((item) => KanjiDto.fromJson(jsonDecode(item))).toList();
  }
}