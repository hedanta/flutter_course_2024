class Kanji {
  final String kanji;
  final String heisig;
  final List<String> meanings;
  final List<String> kunReadings;
  final List<String> onReadings;
  final int jlpt;

  Kanji({
    required this.kanji,
    required this.heisig,
    required this.meanings,
    required this.kunReadings,
    required this.onReadings,
    required this.jlpt,
  });

  Map<String, dynamic> toJson() {
    return {
      'kanji': kanji,
      'heisig': heisig,
      'meanings': meanings,
      'kunReadings': kunReadings,
      'onReadings': onReadings,
      'jlpt': jlpt,
    };
  }

  static Kanji fromJson(Map<String, dynamic> json) {
    return Kanji(
      kanji: json['kanji'],
      heisig: json['heisig'],
      meanings: List<String>.from(json['meanings']),
      kunReadings: List<String>.from(json['kunReadings']),
      onReadings: List<String>.from(json['onReadings']),
      jlpt: json['jlpt'],
    );
  }
}