class LocationInfo {
  final String cityName;
  final double lon;
  final double lat;
  final int? temperature;
  final String? weatherIconCode;

  LocationInfo({
    required this.cityName,
    required this.lon,
    required this.lat,
    this.temperature,
    this.weatherIconCode,
  });

  factory LocationInfo.undefined() {
    return LocationInfo(
      cityName: 'Москва',
      lon: 37.6172999,
      lat: 55.755826,
    );
  }

  factory LocationInfo.fromJson(Map<dynamic, dynamic> json) {
    final temp = json['main']?['temp'];
    final iconCode = json['weather']?[0]?['icon'];
    return LocationInfo(
      cityName: json['name'],
      lon: json['coord']?['lon'],
      lat: json['coord']?['lat'],
      temperature: temp?.toInt(),
      weatherIconCode: iconCode,
    );
  }
}
