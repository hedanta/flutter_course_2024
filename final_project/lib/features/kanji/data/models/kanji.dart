class Kanji {
  final String kanji;
  final String heiseg;
  final List<String> meanings;
  final List<String> kunReadings;
  final List<String> onReadings;
  final int jlpt;

  const Kanji({
      this.kanji = '',
      this.heiseg = '',
      this.meanings = const [],
      this.kunReadings = const [],
      this.onReadings = const [],
      this.jlpt = 0,
  });
}