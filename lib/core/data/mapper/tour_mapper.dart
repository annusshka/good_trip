import 'package:good_trip/core/data/models/api_tour/api_tour_property.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';

Excursion mapApiResponseToTour(ApiTourProperty dto) {
  Address address = mapApiResponseToAddress(dto.address, dto.point);

  return Excursion(
    id: dto.xid,
    name: dto.name,
    kinds: dto.kinds.split(','),
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
    house: dto.houseNumber ?? '',
    coordinates: Point(lon: point.lon, lat: point.lat),
  );
}

AddressDto mapApiResponseToAddressDto(Map<String, dynamic> data) {
  return AddressDto(
    country: data['address']['country'] ?? '',
    city: data['address']['city'] ?? '',
    street: data['address']['road'] ?? '',
    houseNumber: data['address']['house_number'] ?? '',
  );
}

Address mapDtoToAddress(AddressDto dto) {
  return Address(
    coordinates: dto.coordinates,
    country: dto.country ?? '',
    city: dto.city ?? '',
    street: dto.street ?? '',
    house: dto.houseNumber ?? '',
  );
}

AddressDto mapAddressToDto(Address address) {
  return AddressDto(
    country: address.country,
    city: address.city,
    street: address.street,
    houseNumber: address.house,
  );
}

Excursion mapDtoToExcursion(ExcursionDto dto) {
  return Excursion(
    id: dto.id,
    name: dto.name,
    imageUrl: dto.imageUrl,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: dto.kinds,
    isLiked: dto.isLiked,
    deeplinkUrl: dto.deeplinkUrl,
  );
}

ExcursionDto mapExcursionToDto(Excursion tour) {
  return ExcursionDto(
    id: tour.id,
    name: tour.name,
    imageUrl: tour.imageUrl,
    address: mapAddressToDto(tour.address as Address),
    weekdays: tour.weekdays,
    description: tour.description,
    kinds: tour.kinds,
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
    id: dto.id,
    name: dto.name,
    imageUrl: dto.imageUrl,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: dto.kinds,
    isLiked: dto.isLiked,
    deeplinkUrl: dto.deeplinkUrl,
    audioUrl: dto.audioUrl,
  );
}

AudioExcursionDto mapAudioExcursionToDto(IAudioExcursion audioExcursion) {
  return AudioExcursionDto(
    id: audioExcursion.id,
    name: audioExcursion.name,
    imageUrl: audioExcursion.imageUrl,
    address: mapAddressToDto(audioExcursion.address as Address),
    weekdays: audioExcursion.weekdays,
    description: audioExcursion.description,
    kinds: audioExcursion.kinds,
    isLiked: audioExcursion.isLiked,
    deeplinkUrl: audioExcursion.deeplinkUrl,
    audioUrl: audioExcursion.audioUrl,
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
    id: dto.id,
    name: dto.name,
    imageUrl: dto.imageUrl,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: dto.kinds,
    isLiked: dto.isLiked,
    deeplinkUrl: dto.deeplinkUrl,
    excursionList: mapDtoToAudioExcursionList(dto.excursionList),
  );
}

TourDto mapTourToDto(Tour tour) {
  return TourDto(
    id: tour.id,
    name: tour.name,
    imageUrl: tour.imageUrl,
    address: mapAddressToDto(tour.address),
    weekdays: tour.weekdays,
    description: tour.description,
    kinds: tour.kinds,
    isLiked: tour.isLiked,
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