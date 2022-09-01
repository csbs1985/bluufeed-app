import 'package:flutter/cupertino.dart';

ValueNotifier<CategoryModel> currentMenuSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

class CategoryModel {
  final String? id;
  final String? label;
  final bool? isShowMenu;
  final bool? isShowInput;
  final bool? isDisabled;

  CategoryModel({
    this.id,
    this.label,
    this.isShowMenu,
    this.isShowInput,
    this.isDisabled,
  });

  static List<CategoryModel> allCategories = [
    CategoryModel(
      id: CategoriesEnum.ALL.name,
      label: 'todas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.MY.name,
      label: 'minhas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.SAVE.name,
      label: 'salvas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.ANIMALS.name,
      label: 'animais',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.ASTROLOY.name,
      label: 'astrologia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.ASTRONOMY.name,
      label: 'astronomia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.DRINK.name,
      label: 'bebida',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.BEAUTY.name,
      label: 'beleza',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.SCIENCE.name,
      label: 'ciências',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.CLIMATE_WEATHER.name,
      label: 'clima e tempo',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.COMEDY.name,
      label: 'comédia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.FOOD.name,
      label: 'comida',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.CULTURE.name,
      label: 'cultura',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.MONEY.name,
      label: 'dinheiro',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.ENTERTAINMENT.name,
      label: 'entretenimento',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.SPORTS.name,
      label: 'esportes',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.STUDIES.name,
      label: 'estudos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.EVENTS.name,
      label: 'eventos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.EXTRATERRESTRIAL.name,
      label: 'extraterrestre',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.FAMILY.name,
      label: 'família',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.FOLKLORE.name,
      label: 'folclore',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.PHOTOGRAPHY_VIDEOS.name,
      label: 'fotografia e vídeos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.GEOGRAPHY.name,
      label: 'geografia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.INTERNET.name,
      label: 'internet',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.FASHION.name,
      label: 'moda',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.SONG.name,
      label: 'música',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.RELIGION.name,
      label: 'religião',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.ROMANCE.name,
      label: 'romance',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.HEALTH.name,
      label: 'saúde',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.SEX.name,
      label: 'sexo',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.TATTOO_PIERCING.name,
      label: 'tatuagem e piercing',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.TECHNOLOGY.name,
      label: 'tecnologia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.HORROR.name,
      label: 'terror',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.JOB.name,
      label: 'trabalho',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.TRANSPORT.name,
      label: 'transportes',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.TV_MOVIES_SERIES.name,
      label: 'tv, filmes e séries',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.VEHICLES.name,
      label: 'veículos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    CategoryModel(
      id: CategoriesEnum.VIOLENCE.name,
      label: 'violência',
      isShowMenu: true,
      isShowInput: true,
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

enum CategoriesEnum {
  ALL,
  ANIMALS,
  ASTROLOY,
  ASTRONOMY,
  BEAUTY,
  COMEDY,
  CLIMATE_WEATHER,
  CULTURE,
  DRINK,
  ENTERTAINMENT,
  EVENTS,
  EXTRATERRESTRIAL,
  FAMILY,
  FASHION,
  FOLKLORE,
  FOOD,
  GEOGRAPHY,
  HEALTH,
  HORROR,
  INTERNET,
  JOB,
  MONEY,
  MY,
  PHOTOGRAPHY_VIDEOS,
  RELIGION,
  ROMANCE,
  SAVE,
  SEX,
  SCIENCE,
  SONG,
  SPORTS,
  STUDIES,
  TATTOO_PIERCING,
  TECHNOLOGY,
  TRANSPORT,
  TV_MOVIES_SERIES,
  VEHICLES,
  VIOLENCE,
}
