// import 'package:postgres/postgres.dart';
//
// import '../models.dart';
//
// class AudioTour implements BaseTour {
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
//   String audioFile;
//
//   AudioTour({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.weekdays,
//     required this.coordinates,
//     required this.description,
//     required this.kinds,
//     required this.address,
//     required this.isLiked,
//     required this.audioFile,
//   });
//
//   AudioTour copyWith({
//     final String? id,
//     final String? name,
//     final String? image,
//     final List<Weekday>? weekdays,
//     final Point? coordinates,
//     final String? description,
//     final List<String>? kinds,
//     final AddressDto? address,
//     final bool? isLiked,
//     final String? audioFile,
//   }) {
//     return AudioTour(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         image: image ?? this.image,
//         weekdays: weekdays ?? this.weekdays,
//         coordinates: coordinates ?? this.coordinates,
//         description: description ?? this.description,
//         kinds: kinds ?? this.kinds,
//         address: address ?? this.address,
//         isLiked: isLiked ?? this.isLiked,
//         audioFile: audioFile ?? this.audioFile);
//   }
//
//   factory AudioTour.fromJson(Map<String, dynamic> json) {
//     List<String> values = (json['kinds'] as List<dynamic>).cast<String>();
//     List<Weekday>? weekdays = json['weekdays'] != null
//         ? (json['weekdays'] as List<dynamic>)
//             .map((e) => {Weekday.values.byName(e.toLowerCase())})
//             .toList()
//             .cast<Weekday>()
//         : null;
//     return AudioTour(
//         id: json['id'].toString(),
//         name: json['name'],
//         image: json['imagePath'],
//         weekdays: weekdays,
//         //coordinates: Point(json['lat'], json['lon']),
//         coordinates: const Point(0, 0),
//         description: json['description'],
//         kinds: values,
//         address: AddressDto.fromJson(json['address']),
//         isLiked: json['liked'],
//         audioFile: json['audioPath']);
//   }
//
//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'weekdays': weekdays?.map((i) => i.name.toUpperCase()).toList(),
//         'description': description,
//         'kinds': kinds,
//         'address': address.toJson(),
//         'liked': isLiked
//       };
//
//   @override
//   String getWeekdays() {
//     return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
//   }
// }
