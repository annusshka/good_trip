import 'package:good_trip/core/data/models/api_tour/api_tour_property.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';

Tour mapApiResponseToTour(ApiTourProperty dto) {
  Address address = mapApiResponseToAddress(dto.address, dto.point);

  return Tour(
    id: dto.xid,
    name: dto.name,
    kinds: dto.kinds.split(','),
    image: dto.image,
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
    coordinates: [point.lon, point.lat],
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
    coordinates: [],
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

Tour mapDtoToTour(TourDto dto) {
  return Tour(
    id: dto.id,
    name: dto.name,
    image: dto.image,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: dto.kinds,
    isLiked: dto.isLiked,
    url: dto.url,
  );
}

TourDto mapTourToDto(Tour tour) {
  return TourDto(
    id: tour.id,
    name: tour.name,
    image: tour.image,
    address: mapAddressToDto(tour.address as Address),
    weekdays: tour.weekdays,
    description: tour.description,
    kinds: tour.kinds,
    isLiked: tour.isLiked,
    url: tour.url,
  );
}

List<TourDto> mapTourListToDto(
  List<Tour> tourList,
) {
  return tourList.map(mapTourToDto).toList();
}

List<Tour> mapDtoToTourList(
  List<TourDto> tourList,
) {
  return tourList.map(mapDtoToTour).toList();
}

AudioTour mapDtoToAudioTour(AudioTourDto dto) {
  return AudioTour(
    id: dto.id,
    name: dto.name,
    image: dto.image,
    address: mapDtoToAddress(dto.address),
    weekdays: dto.weekdays,
    description: dto.description,
    kinds: dto.kinds,
    isLiked: dto.isLiked,
    url: dto.url,
    audio: dto.audio,
  );
}

AudioTourDto mapAudioTourToDto(AudioTour audioTour) {
  return AudioTourDto(
    id: audioTour.id,
    name: audioTour.name,
    image: audioTour.image,
    address: mapAddressToDto(audioTour.address as Address),
    weekdays: audioTour.weekdays,
    description: audioTour.description,
    kinds: audioTour.kinds,
    isLiked: audioTour.isLiked,
    url: audioTour.url,
    audio: audioTour.audio,
  );
}

List<AudioTourDto> mapAudioTourListToDto(
  List<AudioTour> tourList,
) {
  return tourList.map(mapAudioTourToDto).toList();
}

List<AudioTour> mapDtoToAudioTourList(
  List<AudioTourDto> tourList,
) {
  return tourList.map(mapDtoToAudioTour).toList();
}

User mapDtoToUser(UserDto dto) {
  return User(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    surname: dto.surname,
    phone: dto.phone,
    password: dto.password,
    role: dto.role,
  );
}

UserDto mapUserToDto(User user) {
  return UserDto(
    id: user.id,
    name: user.name,
    email: user.email,
    surname: user.surname,
    phone: user.phone,
    password: user.password,
    role: user.role,
  );
}

List<UserDto> mapUserListToDto(
  List<User> users,
) {
  return users.map(mapUserToDto).toList();
}

List<User> mapDtoToUserList(
  List<UserDto> users,
) {
  return users.map(mapDtoToUser).toList();
}
