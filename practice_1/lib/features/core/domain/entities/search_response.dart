class SearchResponse {
  final int temp;
  final String type;

  const SearchResponse(this.temp, this.type);

  @override
  String toString() {
    return 'SearchResponse{temp: $temp, type: $type}';
  }
}

class SearchResponseOM extends SearchResponse {
  final int windSpeed;
  final int isDay;
  final int minTemp;
  final int maxTemp;

  SearchResponseOM(super.temp, super.type, this.windSpeed, this.isDay,
                   this.minTemp, this.maxTemp);

  @override
  String toString() {
    return 'SearchResponseOM{temp: $temp, type: $type, windSpeed: $windSpeed, '
        'isDay: $isDay, minTemp: $minTemp, maxTemp: $maxTemp}';
  }
}

enum WeatherType {clear, rain, cloudy, snow, fog, thunderstorm, other}
extension WeatherTypeExtension on WeatherType {
  String toTypeString() {
    return toString().split('.').last;
  }
}