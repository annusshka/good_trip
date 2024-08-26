enum TourType {
  accomodations,
  adult,
  amusements,
  interesting_places,
  cultural,
  architecture,
  museums,
  theatres_and_entertainments,
  archaeology,
  burial_places,
  monuments_and_memorials,
  natural,
  beaches,
  geological_formations,
  islands,
  natural_springs,
  nature_reserves,
  water,
  religion,
  sport,
  climbing,
  diving,
  winter_sports,
  banks,
  foods,
  shops,
  transport
}

extension Extention on TourType {
  String get displayText {
    switch (this) {
      case TourType.accomodations:
        return 'Жильё';
      case TourType.adult:
        return 'Для взрослых';
      case TourType.amusements:
        return 'Развлечения';
      case TourType.interesting_places:
        return 'Интересные места';
      case TourType.cultural:
        return 'Культура';
      case TourType.architecture:
        return 'Архитектура';
      case TourType.museums:
        return 'Музей';
      case TourType.theatres_and_entertainments:
        return 'Театр и развлечения';
      case TourType.archaeology:
        return 'Археология';
      case TourType.burial_places:
        return 'Место захоронений';
      case TourType.monuments_and_memorials:
        return 'Монументы и мемориалы';
      case TourType.natural:
        return 'Природа';
      case TourType.beaches:
        return 'Пляж';
      case TourType.geological_formations:
        return 'Геологическая порода';
      case TourType.islands:
        return 'Остров';
      case TourType.natural_springs:
        return 'Естественный источник';
      case TourType.nature_reserves:
        return 'Заповедник';
      case TourType.water:
        return 'Вода';
      case TourType.religion:
        return 'Религия';
      case TourType.sport:
        return 'Спорт';
      case TourType.climbing:
        return 'Скалолазание';
      case TourType.diving:
        return 'Дайвинг';
      case TourType.winter_sports:
        return 'Зимний спорт';
      case TourType.banks:
        return 'Банк';
      case TourType.foods:
        return 'Еда';
      case TourType.shops:
        return 'Магазин';
      case TourType.transport:
        return 'Транспорт';
    }
  }

  String get displayEnglishText {
    switch (this) {
      case TourType.accomodations:
        return 'accomodations';
      case TourType.adult:
        return 'adult';
      case TourType.amusements:
        return 'amusements';
      case TourType.interesting_places:
        return 'interesting_places';
      case TourType.cultural:
        return 'cultural';
      case TourType.architecture:
        return 'architecture';
      case TourType.museums:
        return 'architecture';
      case TourType.theatres_and_entertainments:
        return 'theatres_and_entertainments';
      case TourType.archaeology:
        return 'archaeology';
      case TourType.burial_places:
        return 'burial_places';
      case TourType.monuments_and_memorials:
        return 'monuments_and_memorials';
      case TourType.natural:
        return 'natural';
      case TourType.beaches:
        return 'beaches';
      case TourType.geological_formations:
        return 'geological_formations';
      case TourType.islands:
        return 'islands';
      case TourType.natural_springs:
        return 'natural_springs';
      case TourType.nature_reserves:
        return 'nature_reserves';
      case TourType.water:
        return 'water';
      case TourType.religion:
        return 'religion';
      case TourType.sport:
        return 'sport';
      case TourType.climbing:
        return 'climbing';
      case TourType.diving:
        return 'diving';
      case TourType.winter_sports:
        return 'winter_sports';
      case TourType.banks:
        return 'banks';
      case TourType.foods:
        return 'foods';
      case TourType.shops:
        return 'shops';
      case TourType.transport:
        return 'transport';
    }
  }
}
