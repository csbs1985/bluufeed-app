import 'package:flutter/cupertino.dart';

ValueNotifier<CategoryModel> currentCategory =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

class CategoryModel {
  final String? id;
  final String? label;
  final bool? isLogin;
  final bool? isDisabled;

  CategoryModel({
    this.id,
    this.label,
    this.isLogin,
    this.isDisabled,
  });

  static List<CategoryModel> allCategories = [
    CategoryModel(
      id: CategoryEnum.ALL.value,
      label: 'todas',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ANIMALS.value,
      label: 'animais',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ART.value,
      label: 'arte',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ASTROLOY.value,
      label: 'astrologia',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ASTRONOMY.value,
      label: 'astronomia',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.DRINK.value,
      label: 'bebida',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.BEAUTY.value,
      label: 'beleza',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SCIENCE.value,
      label: 'ciências',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.CLIMATE_WEATHER.value,
      label: 'clima e tempo',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.COMEDY.value,
      label: 'comédia',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FOOD.value,
      label: 'comida',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.CULTURE.value,
      label: 'cultura',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.MONEY.value,
      label: 'dinheiro',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ENTERTAINMENT.value,
      label: 'entretenimento',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SPORTS.value,
      label: 'esportes',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.STUDIES.value,
      label: 'estudos',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.EVENTS.value,
      label: 'eventos',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.EXTRATERRESTRIAL.value,
      label: 'extraterrestre',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FAMILY.value,
      label: 'família',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FOLKLORE.value,
      label: 'folclore',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.PHOTOGRAPHY_VIDEO.value,
      label: 'fotografia e vídeos',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.GEOGRAPHY.value,
      label: 'geografia',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.INTERNET.value,
      label: 'internet',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FASHION.value,
      label: 'moda',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.MUSIC.value,
      label: 'música',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.RELIGION.value,
      label: 'religião',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ROMANCE.value,
      label: 'romance',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.HEALTH.value,
      label: 'saúde',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SEX.value,
      label: 'sexo',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TATTOO_PIERCING.value,
      label: 'tatuagem e piercing',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TECHNOLOGY.value,
      label: 'tecnologia',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.HORROR.value,
      label: 'terror',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.JOB.value,
      label: 'trabalho',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TRANSPORT.value,
      label: 'transportes',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TV_MOVIES_SERIES.value,
      label: 'tv, filmes e séries',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.VEHICLES.value,
      label: 'veículos',
      isLogin: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.VIOLENCE.value,
      label: 'violência',
      isLogin: false,
      isDisabled: false,
    )
  ];
}

class CategoriesClass {
  getCategoryLabel(String _item) {
    for (var item in CategoryModel.allCategories)
      if (item.id == _item) return item.label;
  }
}

enum CategoryEnum {
  ALL('all'),
  ART('art'),
  ANIMALS('animals'),
  ASTROLOY('astrology'),
  ASTRONOMY('astronomy'),
  BEAUTY('beauty'),
  COMEDY('comedy'),
  CLIMATE_WEATHER('climate_weather'),
  CULTURE('culture'),
  DRINK('drink'),
  ENTERTAINMENT('entertainment'),
  EVENTS('events'),
  EXTRATERRESTRIAL('extraterrestrial'),
  FAMILY('family'),
  FASHION('fashion'),
  FOLKLORE('folklore'),
  FOOD('food'),
  GEOGRAPHY('geography'),
  HEALTH('health'),
  HORROR('horror'),
  INTERNET('internet'),
  JOB('job'),
  MONEY('money'),
  MUSIC('music'),
  MY('my'),
  PHOTOGRAPHY_VIDEO('photagraphy_video'),
  RELIGION('religion'),
  ROMANCE('romance'),
  SAVE('save'),
  SEX('sex'),
  SCIENCE('sciencie'),
  SPORTS('sports'),
  STUDIES('studies'),
  TATTOO_PIERCING('tottoo_piercing'),
  TECHNOLOGY('technology'),
  TRANSPORT('transport'),
  TV_MOVIES_SERIES('tv_movies_series'),
  VEHICLES('vehicles'),
  VIOLENCE('violence');

  final String value;
  const CategoryEnum(this.value);
}
