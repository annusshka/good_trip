abstract class IAddress {
  IAddress({
    required this.coordinates,
    required this.country,
    required this.city,
    required this.street,
    required this.house,
  });

  final List<double> coordinates;
  final String country;
  final String city;
  final String street;
  final String house;

  Map<String, dynamic> toJson();
}