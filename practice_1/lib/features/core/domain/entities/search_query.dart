abstract class SearchQuery {}

class SearchQueryCity extends SearchQuery {
  final String city;

  SearchQueryCity(this.city);
}

class SearchQueryCoord extends SearchQuery {
  final double lat;
  final double long;

  SearchQueryCoord(this.lat, this.long);
}