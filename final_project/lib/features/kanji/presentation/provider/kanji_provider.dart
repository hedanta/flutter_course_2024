import 'package:flutter/material.dart';

import 'package:final_project/features/kanji/domain/entities/kanji.dart';
import 'package:final_project/features/kanji/data/data_sources/kanji_local.dart';
import 'package:final_project/features/kanji/data/kanji_repository.dart';

class KanjiProvider extends ChangeNotifier {
  final KanjiLocalDataSource _kanjiLocalDataSource;
  final KanjiRepository _kanjiRepository;

  KanjiProvider(this._kanjiLocalDataSource, this._kanjiRepository) {
    loadStarredKanjis();
  }

  List<Kanji> _starredKanjis = [];
  Kanji? kanjiInfo;
  String? errorMessage;
  bool isLoading = false;
  bool _isError = false;
  bool isKanjiFound = false;

  List<Kanji> get starredKanjis => _starredKanjis;
  bool get isError => _isError;

  Future<void> loadStarredKanjis() async {
    _starredKanjis = await _kanjiLocalDataSource.getStarredKanjis();
    notifyListeners();
  }

  bool isKanjiStarred(Kanji kanji) {
    return _starredKanjis.any((starred) => starred.kanji == kanji.kanji);
  }

  Future<void> toggleStarredKanji(Kanji kanji) async {
    if (isKanjiStarred(kanji)) {
      _starredKanjis.removeWhere((starred) => starred.kanji == kanji.kanji);
      await _kanjiLocalDataSource.deleteStarredKanji(kanji);
    } else {
      _starredKanjis.add(kanji);
      await _kanjiLocalDataSource.saveStarredKanji(kanji);
    }
    notifyListeners();
  }

  Future<void> removeStarredKanji(Kanji kanji) async {
    _starredKanjis.removeWhere((starred) => starred.kanji == kanji.kanji);
    await _kanjiLocalDataSource.deleteStarredKanji(kanji);
    notifyListeners();
  }

  Future<void> fetchKanjiInfo(String kanji) async {
    isLoading = true;
    _isError = false;
    isKanjiFound = false;
    errorMessage = null;
    notifyListeners();

    if (kanji.trim().isEmpty) {
      isLoading = false;
      _isError = false;
      isKanjiFound = false;
      notifyListeners();
      return;
    }

    try {
      kanjiInfo = await _kanjiRepository.fetchKanjiInfo(kanji);
      errorMessage = null;
      isKanjiFound = true;
    } catch (e) {
      kanjiInfo = Kanji(kanji: '', heisig: '', meanings: [], kunReadings: [], onReadings: [], jlpt: 0);
      errorMessage = 'Kanji not found';
      _isError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}