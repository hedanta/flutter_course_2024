class OMWeather {
  final double temp;
  final int type;

  const OMWeather(this.temp, this.type);

  @override
  String toString() {
    return 'OMWeather{temp: $temp, type: $type}';
  }
}