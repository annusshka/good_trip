// import 'package:postgres/postgres.dart';
//
// import '../models.dart';
//
// class Tour implements BaseTour {
//   @override
//   String id;
//   @override
//   String name;
//   @override
//   String? image;
//   @override
//   List<Weekday>? weekdays;
//   @override
//   Point coordinates;
//   @override
//   String? description;
//   @override
//   List<String> kinds;
//   @override
//   AddressDto address;
//   @override
//   bool isLiked;
//
//   Tour({
//     required this.id,
//     required this.name,
//     this.image,
//     this.weekdays,
//     required this.coordinates,
//     this.description,
//     required this.kinds,
//     required this.address,
//     this.isLiked = false,
//   });
//
//   Tour.undefined()
//       : this(
//             id: '',
//             name: 'Воронеж',
//             coordinates: const Point(39.1843, 51.672),
//             kinds: [''],
//             address: const AddressDto(country: 'Россия', city: 'Воронеж'));
//
//   Tour copyWith({
//     final String? id,
//     final String? name,
//     final String? image,
//     final List<Weekday>? weekdays,
//     final Point? coordinates,
//     final String? description,
//     final List<String>? kinds,
//     final AddressDto? address,
//     final bool? isLiked,
//   }) {
//     return Tour(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         image: image ?? this.image,
//         weekdays: weekdays ?? this.weekdays,
//         coordinates: coordinates ?? this.coordinates,
//         description: description ?? this.description,
//         kinds: kinds ?? this.kinds,
//         address: address ?? this.address,
//         isLiked: isLiked ?? this.isLiked);
//   }
//
//   factory Tour.fromJson(Map<dynamic, dynamic> json) {
//     return Tour(
//         id: json['id'].toString(),
//         name: json['name'],
//         image: json['image'],
//         weekdays: json['weekday'],
//         coordinates: const Point(0, 0),
//         //coordinates: Point(json['lat'], json['lon']),
//         description: json['description'],
//         kinds: json['kinds'],
//         address: json['address'],
//         isLiked: json['isLiked']);
//   }
//
//   @override
//   String getWeekdays() {
//     throw "${weekdays?.map((el) => el.displayTitle).join(', ')}";
//   }
// }
