enum AccessLevel {
  user,
  localguide,
  admin
}

extension AccessLevelExtension on AccessLevel {
  String get displayTitle {
    switch (this) {
      case AccessLevel.user:
        return 'Пользователь';
      case AccessLevel.localguide:
        return 'Экскурсовод';
      case AccessLevel.admin:
        return 'Админ';
    }
  }
}