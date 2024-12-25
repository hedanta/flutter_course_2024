import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:final_project/features/kanji/data/kanji_api.dart';
import 'kanji_api_test.mocks.dart';

void main() {
  late KanjiApi api;
  late MockClient client;
  const String fakeApiUrl = 'https://meow.com';

  setUp(() {
    client = MockClient();
    api = KanjiApi(fakeApiUrl, client: client);
  });

  group('KanjiApi Tests', () {
    test('Should return Kanji object on valid response', () async {
      const kanjiChar = '日';
      final mockResponse = {
        'kanji': '日',
        'heiseg': '1',
        'meanings': ['sun', 'day'],
        'kun_readings': ['ひ', 'び'],
        'on_readings': ['ニチ', 'ジツ'],
        'jlpt': 5
      };

      when(client.get(Uri.parse('$fakeApiUrl/kanji/$kanjiChar')))
          .thenAnswer((_) async => http.Response(
        jsonEncode(mockResponse),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ));

      final result = await api.getKanjiInfo(kanjiChar);

      expect(result.kanji, '日');
      expect(result.meanings, ['sun', 'day']);
    });

    test('Should throw KanjiNotFoundException when kanji not found', () async {
      const kanjiChar = '不存在';
      final mockResponse = {'error': 'Kanji not found'};

      when(client.get(Uri.parse('$fakeApiUrl/kanji/$kanjiChar')))
          .thenAnswer((_) async => http.Response(
        jsonEncode(mockResponse),
        404,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ));

      expect(
            () async => await api.getKanjiInfo(kanjiChar),
        throwsA(isA<KanjiNotFoundException>()),
      );
    });

    test('Should throw exception on invalid JSON', () async {
      const kanjiChar = '日';

      when(client.get(Uri.parse('$fakeApiUrl/kanji/$kanjiChar')))
          .thenAnswer((_) async => http.Response(
        'invalid json',
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ));

      expect(
            () async => await api.getKanjiInfo(kanjiChar),
        throwsA(isA<FormatException>()),
      );
    });
  });
}