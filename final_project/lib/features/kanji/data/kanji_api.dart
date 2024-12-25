import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/kanji.dart';

class KanjiApi {
  final String kanjiUrl;
  final http.Client client;

  KanjiApi(this.kanjiUrl, {http.Client? client}) : client = client ?? http.Client();

  Future<Kanji> getKanjiInfo(String kanjiChar) async {
    var response = await client.get(Uri.parse('$kanjiUrl/kanji/$kanjiChar'));
    var rJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (rJson['error'] != null) {
      throw KanjiNotFoundException('Kanji $kanjiChar not found.');
    }
    return Kanji(
      kanji: rJson['kanji'] ?? '',
      heiseg: rJson['heiseg'] ?? '',
      meanings: (rJson['meanings'] as List<dynamic>?)?.cast<String>() ?? [],
      kunReadings: (rJson['kun_readings'] as List<dynamic>?)?.cast<String>() ?? [],
      onReadings: (rJson['on_readings'] as List<dynamic>?)?.cast<String>() ?? [],
      jlpt: rJson['jlpt'] ?? 0,
    );
  }
}

class KanjiNotFoundException implements Exception {
  final String message;
  KanjiNotFoundException(this.message);

  @override
  String toString() => 'KanjiNotFoundException: $message';
}

