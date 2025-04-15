abstract class Urls {
  static const refresh = '/auth/refresh';
  static const register ='/auth/register';
  static const login = '/auth/authentication';

  static const user = '/user';
  static const excursionsByAdmin = '/admin/excursions';
  static const toursByAdmin = '/admin/tours';
  static const getAccountList = '/admin/users';
  static const deleteAccountByAdmin = '/admin/user';

  static const likeExcursion = '/audioexcursion/like';
  static const createdExcursion = '/audioexcursion/created';
  static const excursionsByCity = '/audioexcursion/city';
  static const audioExcursion = '/audioexcursion';
  static const createExcursion = '/audioexcursion/create';
  static const createExcursionFiles = '/audioexcursion/create/files';
  static const excursionTypes = '/auth/excursions/types';

  static const likeTour = '/audiotours/like';
  static const createdTour = '/audiotours/created';
  static const toursByCity = '/audiotours/city';
  static const audioTour = '/audiotours';
  static const createTour = '/audiotours/create';
  static const createTourFiles = '/audiotours/create/files';

  static const welcome = '/auth/welcome';
}