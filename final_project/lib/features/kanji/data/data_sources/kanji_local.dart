import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:final_project/features/kanji/domain/entities/kanji.dart';

class KanjiLocalDataSource {
  static const String _starredKanjisKey = 'starred_kanjis';

  Future<void> saveStarredKanji(Kanji kanji) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    starredKanjis.add(jsonEncode(kanji.toJson()));
    await prefs.setStringList(_starredKanjisKey, starredKanjis);
  }

  Future<void> deleteStarredKanji(Kanji kanji) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    starredKanjis.removeWhere((item) => Kanji.fromJson(jsonDecode(item)).kanji == kanji.kanji);
    await prefs.setStringList(_starredKanjisKey, starredKanjis);
  }

  Future<List<Kanji>> getStarredKanjis() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> starredKanjis = prefs.getStringList(_starredKanjisKey) ?? [];
    return starredKanjis.map((item) => Kanji.fromJson(jsonDecode(item))).toList();
  }
}