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
}