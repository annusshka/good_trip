abstract class Urls {
  static const user = '/auth/users';
  static const refresh = '/auth/refresh';
  static const register ='/auth/register';
  static const login = '/auth/authentication';

  static const excursionsByCity = '/auth/tours/audio/city';
  static const audio = '/auth/tours/audio';
  static const excursionsByAdmin = '/auth/admin/tours';
  static const likeExcursion = '/auth/users/likes';
  static const createExcursion = '/auth/tours/audio/created';
  static const excursionTypes = '/auth/tours/types';

  static const toursByCity = '/auth/tours/audio/city';
  static const audioTour = '/auth/tours/audio';
  static const toursByAdmin = '/auth/admin/tours';
  static const likeTour = '/auth/users/likes';
  static const createTour = '/auth/tours/audio/created';

  static const getAccountList = '/auth/admin/users';
  static const deleteAccountByAdmin = '/auth/admin/user';

  static const welcome = '/auth/welcome';
}