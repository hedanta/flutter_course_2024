import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:final_project/features/kanji/domain/entities/kanji.dart';

class KanjiApi {
  final String apiUrl;
  final http.Client client;

  KanjiApi(this.apiUrl, {http.Client? client})
      : client = client ?? http.Client();

  Future<Kanji> fetchKanjiInfo(String kanjiChar) async {
    var response = await client.get(Uri.parse('$apiUrl/kanji/$kanjiChar'));
    var rJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (rJson['error'] != null) {
      throw KanjiNotFoundException('Kanji $kanjiChar not found.');
    }
    return _kanjiFromJson(rJson);
  }

  Kanji _kanjiFromJson(Map<String, dynamic> json) {
    return Kanji(
      kanji: json['kanji'] ?? '',
      heisig: json['heisig_en'] ?? '',
      meanings: List<String>.from(json['meanings'] ?? []),
      kunReadings: List<String>.from(json['kun_readings'] ?? []),
      onReadings: List<String>.from(json['on_readings'] ?? []),
      jlpt: json['jlpt'] ?? 0,
    );
  }
}

class KanjiNotFoundException implements Exception {
  final String message;
  KanjiNotFoundException(this.message);

  @override
  String toString() => 'KanjiNotFoundException: $message';
}

