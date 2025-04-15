import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/models/api_tour/api_tour_property.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';

Excursion mapApiResponseToTour(ApiTourProperty dto) {
  Address address = mapApiResponseToAddress(dto.address, dto.point);

  return Excursion(
    id: dto.xid,
    name: dto.name,
    kinds: mapToTourType(dto.kinds.split(',')),
    imageUrl: dto.image,
    description: dto.info?.descr,
    address: address,
  );
}

Address mapApiResponseToAddress(AddressDto? dto, Point? point) {
  if (dto == null || point == null) {
    throw TourError(
      name: 'GetTourDetailsByApi',
      message: 'Address is incorrect',
      errorText: 'Address is incorrect',
    );
  }
  return Address(
    country: dto.country ?? '',
    city: dto.city ?? '',
    street: dto.road ?? dto.street ?? '',
    house: dto.house ?? '',
    coordinates: Point(lon: point.lon, lat: point.lat),
  );
}

AddressDto mapApiResponseToAddressDto(Map<String, dynamic> data) {
  return AddressDto(
    country: data['address']['country'] ?? '',
    city: data['address']['city'] ?? '',
    street: data['address']['road'] ?? '',
    house: data['address']['house_number'] ?? '',
  );
}

Address mapDtoToAddress(AddressDto dto) {
  return Address(
    coordinates: Point(lon: dto.lon ?? 0.0, lat: dto.lat ?? 0.0),
    country: dto.country ?? '',
    city: dto.city ?? '',
    street: dto.street ?? '',
    house: dto.house ?? '',
  );
}

AddressDto mapAddressToDto(Address address) {
  return AddressDto(
    country: address.country,
    city: address.city,
    street: address.street,
    house: address.house,
    lat: address.coordinates?.lat,
    lon: address.coordinates?.lon,
  );
}

Excursion mapDtoToExcursion(ExcursionDto dto) {
  return Excursion(
    id: dto.id,
    name: dto.name,
    imageUrl: '$baseBDUrl/${dto.imageUrl}',
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: mapToTourType(dto.kinds),
    isLiked: dto.isLiked,
    deeplinkUrl: dto.deeplinkUrl,
  );
}

ExcursionDto mapExcursionToDto(Excursion tour) {
  return ExcursionDto(
    id: tour.id,
    name: tour.name,
    imageUrl: tour.imageUrl?.replaceFirst('$baseBDUrl/', ''),
    address: mapAddressToDto(tour.address as Address),
    weekdays: tour.weekdays,
    description: tour.description,
    kinds: mapFromTourType(tour.kinds),
    isLiked: tour.isLiked,
    deeplinkUrl: tour.deeplinkUrl,
  );
}

List<ExcursionDto> mapExcursionListToDto(
  List<Excursion> excursionList,
) {
  return excursionList.map(mapExcursionToDto).toList();
}

List<Excursion> mapDtoToExcursionList(
  List<ExcursionDto> excursionList,
) {
  return excursionList.map(mapDtoToExcursion).toList();
}

AudioExcursion mapDtoToAudioExcursion(AudioExcursionDto dto) {
  return AudioExcursion(
    id: dto.id.toString(),
    name: dto.name,
    imageUrl: '$baseBDUrl/${dto.imagePath}',
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: mapToTourType(dto.kinds),
    isLiked: dto.liked,
    deeplinkUrl: dto.deeplinkUrl,
    audioUrl: '$baseBDUrl/${dto.audioPath}',
  );
}

AudioExcursionDto mapAudioExcursionToDto(IAudioExcursion audioExcursion) {
  return AudioExcursionDto(
    id: int.tryParse(audioExcursion.id) ?? 0,
    name: audioExcursion.name,
    imagePath: audioExcursion.imageUrl?.replaceFirst('$baseBDUrl/', ''),
    address: mapAddressToDto(audioExcursion.address as Address),
    weekdays: audioExcursion.weekdays,
    description: audioExcursion.description,
    kinds: mapFromTourType(audioExcursion.kinds),
    liked: audioExcursion.isLiked,
    deeplinkUrl: audioExcursion.deeplinkUrl,
    audioPath: audioExcursion.audioUrl.replaceFirst('$baseBDUrl/', ''),
  );
}

List<AudioExcursionDto> mapAudioExcursionListToDto(
  List<IAudioExcursion> tourList,
) {
  return tourList.map(mapAudioExcursionToDto).toList();
}

List<AudioExcursion> mapDtoToAudioExcursionList(
  List<AudioExcursionDto> tourList,
) {
  return tourList.map(mapDtoToAudioExcursion).toList();
}

Tour mapDtoToTour(TourDto dto) {
  return Tour(
    id: dto.id.toString(),
    name: dto.name,
    imageUrl: dto.imagePath,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: mapToTourType(dto.kinds),
    isLiked: dto.liked,
    deeplinkUrl: dto.deeplinkUrl,
    excursionList: mapDtoToAudioExcursionList(dto.excursionList),
  );
}

TourDto mapTourToDto(Tour tour) {
  return TourDto(
    id: int.tryParse(tour.id) ?? 0,
    name: tour.name,
    imagePath: tour.imageUrl,
    address: mapAddressToDto(tour.address),
    weekdays: tour.weekdays,
    description: tour.description,
    kinds: mapFromTourType(tour.kinds),
    liked: tour.isLiked,
    deeplinkUrl: tour.deeplinkUrl,
    excursionList: mapAudioExcursionListToDto(tour.excursionList),
  );
}

List<TourDto> mapToursToDto(
  List<Tour> tourList,
) {
  return tourList.map(mapTourToDto).toList();
}

List<Tour> mapDtoToTours(
  List<TourDto> tourList,
) {
  return tourList.map(mapDtoToTour).toList();
}

List<TourType> mapToTourType(List<String> kinds) {
  List<TourType> tourTypes = [];
  for (final String kind in kinds) {
    try {
      TourType tourType = TourType.values.byName(kind);
      tourTypes.add(tourType);
    } catch (_) {}
  }

  return tourTypes;
}

List<String> mapFromTourType(List<TourType> kinds) {
  List<String> tourTypes = [];
  for (final TourType kind in kinds) {
    String tourType = kind.displayEnglishText;
    tourTypes.add(tourType);
  }

  return tourTypes;
}
