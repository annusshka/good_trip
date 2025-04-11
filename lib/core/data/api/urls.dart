abstract class Urls {
  static const user = '/auth/users';
  static const refresh = '/auth/refresh';
  static const register ='/auth/register';
  static const login = '/auth/authentication';

  static const excursionsByCity = '/auth/excursions/audio/city';
  static const audioExcursion = '/auth/excursions/audio';
  static const createExcursion = '/auth/excursions/audio/created/full';
  static const excursionsByAdmin = '/auth/admin/excursions';
  static const likeExcursion = '/auth/users/excursions/likes';
  static const excursionTypes = '/auth/excursions/types';

  static const toursByCity = '/auth/tours/audio/city';
  static const audioTour = '/auth/tours/audio';
  static const toursByAdmin = '/auth/admin/tours';
  static const likeTour = '/auth/users/tours/likes';
  static const createTour = '/auth/tours/audio/created';

  static const getAccountList = '/auth/admin/users';
  static const deleteAccountByAdmin = '/auth/admin/user';

  static const welcome = '/auth/welcome';
}