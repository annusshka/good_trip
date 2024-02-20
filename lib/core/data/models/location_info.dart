class LocationInfo {
  final String cityName;
  final String lon;
  final String lat;
  final int temperature;
  final String weatherIconCode;

  LocationInfo({required this.cityName, required this.lon, required this.lat,
    required this.temperature, required this.weatherIconCode,
  });

  LocationInfo.undefined(): this(cityName: 'Moscow',
    lon: '37.6172999', lat: '55.755826',
    temperature: 0, weatherIconCode: '04n',);

  factory LocationInfo.fromJson(Map<dynamic, dynamic> json) {
    return LocationInfo(
        cityName: json['name'],
        lon: json['coord']['lon'].toString(),
        lat: json['coord']['lat'].toString(),
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        weatherIconCode: json['weather'][0]['icon'],
        //description: json['weather'][0]['main'],
        //time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
    );
  }
}