abstract class SearchQuery {}

class SearchQueryCity extends SearchQuery {
  final String city;
  final String language;
  SearchQueryCity(this.city, {this.language = 'en'});
}

class SearchQueryCoord extends SearchQuery {
  final double lat;
  final double long;

  SearchQueryCoord(this.lat, this.long);
}