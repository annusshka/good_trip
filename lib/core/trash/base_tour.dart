// import 'package:good_trip/core/data/models/address/address_dto.dart';
// import 'package:good_trip/core/data/models/enum/enum.dart';
// import 'package:postgres/postgres.dart';
//
// class BaseTour {
//   final String id;
//   final String name;
//   final String? image;
//   final List<Weekday>? weekdays;
//   final Point coordinates;
//   final String? description;
//   final List<String> kinds;
//   final AddressDto address;
//   final bool isLiked;
//
//   BaseTour({
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
//   factory BaseTour.fromJson(Map<String, dynamic> json) {
//     List<String> kinds = (json['kinds'] as List<dynamic>).cast<String>();
//     List<Weekday>? weekdays = json['weekdays'] != null
//         ? (json['weekdays'] as List<dynamic>)
//             .map((e) => {Weekday.values.byName(e.toLowerCase())})
//             .toList()
//             .cast<Weekday>()
//         : null;
//     return BaseTour(
//         id: json['id'].toString(),
//         name: json['name'],
//         image: json['imagePath'],
//         weekdays: weekdays,
//         coordinates: const Point(0, 0),
//         description: json['description'],
//         kinds: kinds,
//         address: AddressDto.fromJson(json['address']),
//         isLiked: json['liked']);
//   }
//
//   String getWeekdays() {
//     return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
//   }
// }
