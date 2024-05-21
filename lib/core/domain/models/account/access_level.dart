enum AccessLevel {
  USER,
  ADMIN
}

extension AccessLevelExtension on AccessLevel {
  String get displayTitle {
    switch (this) {
      case AccessLevel.USER:
        return 'Пользователь';
      case AccessLevel.ADMIN:
        return 'Админ';
    }
  }
}