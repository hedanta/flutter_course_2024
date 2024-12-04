class OMWeather {
  final double temp;
  final int type;
  final double windSpeed;
  final int isDay;
  final double minTemp;
  final double maxTemp;

  const OMWeather(this.temp, this.type, this.windSpeed, this.isDay,
                  this.minTemp, this.maxTemp);

  @override
  String toString() {
    return 'OMWeather{temp: $temp, type: $type, windSpeed: $windSpeed, '
                    'isDay: $isDay, minTemp: $minTemp, maxTemp: $maxTemp}';
  }
}