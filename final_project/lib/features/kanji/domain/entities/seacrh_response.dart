class SearchResponse {
  final String kanji;

  const SearchResponse(this.kanji);
}

class SearchResponseKanjiapi extends SearchResponse {
  final String heiseg;
  final List<String> meanings;
  final List<String> kunReadings;
  final List<String> onReadings;
  final int jlpt;

  SearchResponseKanjiapi(
      super.kanji,
      this.heiseg,
      this.meanings,
      this.kunReadings,
      this.onReadings,
      this.jlpt);
}