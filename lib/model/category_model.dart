import 'package:flutter/cupertino.dart';

ValueNotifier<CategoryModel> currentCategory =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

class CategoryModel {
  final String? id;
  final String? label;

  final bool? isDisabled;

  CategoryModel({
    this.id,
    this.label,
    this.isDisabled,
  });

  static List<CategoryModel> allCategories = [
    CategoryModel(
      id: CategoryEnum.ALL.value,
      label: 'todas',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ANIMALS.value,
      label: 'animais',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ART.value,
      label: 'arte',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ASTROLOY.value,
      label: 'astrologia',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ASTRONOMY.value,
      label: 'astronomia',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.DRINK.value,
      label: 'bebida',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.BEAUTY.value,
      label: 'beleza',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SCIENCE.value,
      label: 'ciências',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.CLIMATE_WEATHER.value,
      label: 'clima e tempo',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.COMEDY.value,
      label: 'comédia',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FOOD.value,
      label: 'comida',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.CULTURE.value,
      label: 'cultura',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.MONEY.value,
      label: 'dinheiro',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ENTERTAINMENT.value,
      label: 'entretenimento',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SPORTS.value,
      label: 'esportes',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.STUDIES.value,
      label: 'estudos',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.EVENTS.value,
      label: 'eventos',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.EXTRATERRESTRIAL.value,
      label: 'extraterrestre',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FAMILY.value,
      label: 'família',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FOLKLORE.value,
      label: 'folclore',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.PHOTOGRAPHY_VIDEO.value,
      label: 'fotografia e vídeos',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.GEOGRAPHY.value,
      label: 'geografia',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.INTERNET.value,
      label: 'internet',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.FASHION.value,
      label: 'moda',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.MUSIC.value,
      label: 'música',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.RELIGION.value,
      label: 'religião',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.ROMANCE.value,
      label: 'romance',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.HEALTH.value,
      label: 'saúde',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SEX.value,
      label: 'sexo',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TATTOO_PIERCING.value,
      label: 'tatuagem e piercing',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TECHNOLOGY.value,
      label: 'tecnologia',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.HORROR.value,
      label: 'terror',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.JOB.value,
      label: 'trabalho',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TRANSPORT.value,
      label: 'transportes',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.TV_MOVIES_SERIES.value,
      label: 'tv, filmes e séries',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.VEHICLES.value,
      label: 'veículos',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.LIFE_DEATH.value,
      label: 'vida e morte',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.VIOLENCE.value,
      label: 'violência',
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoryEnum.SHAME.value,
      label: 'vergonha',
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
  LIFE_DEATH('life_death'),
  VIOLENCE('violence'),
  SHAME('shame');

  final String value;
  const CategoryEnum(this.value);
}
