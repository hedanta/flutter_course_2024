import 'package:final_project/features/kanji/domain/entities/kanji.dart';

class KanjiDto {
  static Kanji fromJson(Map<String, dynamic> json) {
    return Kanji(
      kanji: json['kanji'] ?? '',
      heisig: json['heisig'] ?? '',
      meanings: List<String>.from(json['meanings'] ?? []),
      kunReadings: List<String>.from(json['kunReadings'] ?? []),
      onReadings: List<String>.from(json['onReadings'] ?? []),
      jlpt: json['jlpt'] ?? 0,
    );
  }

  static Map<String, dynamic> toJson(Kanji kanji) {
    return {
      'kanji': kanji.kanji,
      'heisig': kanji.heisig,
      'meanings': kanji.meanings,
      'kunReadings': kanji.kunReadings,
      'onReadings': kanji.onReadings,
      'jlpt': kanji.jlpt,
    };
  }
}