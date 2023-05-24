import 'dart:convert';
import 'package:flutter/material.dart';

class CategoriaModel {
  final String idCategoria;
  final String texto;
  final bool isDesabilitada;
  final bool isSelecionar;

  CategoriaModel({
    required this.idCategoria,
    required this.texto,
    required this.isDesabilitada,
    required this.isSelecionar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCategoria': idCategoria,
      'texto': texto,
      'isDesabilitada': isDesabilitada,
      'isSelecionar': isSelecionar,
    };
  }

  static CategoriaModel fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      idCategoria: map['idCategoria'] as String,
      texto: map['texto'] as String,
      isDesabilitada: map['isDesabilitada'] as bool,
      isSelecionar: map['isSelecionar'] as bool,
    );
  }

  factory CategoriaModel.fromJson(String source) =>
      CategoriaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

ValueNotifier<CategoriaModel> currentCategoria =
    ValueNotifier<CategoriaModel>(listaCategoria.first);

final List<CategoriaModel> listaCategoria = [
  CategoriaModel(
    idCategoria: CategoriaEnum.ALL.value,
    texto: 'todas',
    isDesabilitada: false,
    isSelecionar: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.MY.value,
    texto: 'minhas',
    isDesabilitada: false,
    isSelecionar: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.BOOKMARK.value,
    texto: 'favoritas',
    isDesabilitada: false,
    isSelecionar: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ANIMALS.value,
    texto: 'animais',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ART.value,
    texto: 'arte',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ASTROLOY.value,
    texto: 'astrologia',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ASTRONOMY.value,
    texto: 'astronomia',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.DRINK.value,
    texto: 'bebida',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.BEAUTY.value,
    texto: 'beleza',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SCIENCE.value,
    texto: 'ciências',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.CLIMATE_WEATHER.value,
    texto: 'clima e tempo',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.COMEDY.value,
    texto: 'comédia',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FOOD.value,
    texto: 'comida',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.CULTURE.value,
    texto: 'cultura',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.MONEY.value,
    texto: 'dinheiro',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ENTERTAINMENT.value,
    texto: 'entretenimento',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SPORTS.value,
    texto: 'esportes',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.STUDIES.value,
    texto: 'estudos',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.EVENTS.value,
    texto: 'eventos',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.EXTRATERRESTRIAL.value,
    texto: 'extraterrestre',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FAMILY.value,
    texto: 'família',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FOLKLORE.value,
    texto: 'folclore',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.PHOTOGRAPHY_VIDEO.value,
    texto: 'fotografia e vídeos',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.GEOGRAPHY.value,
    texto: 'geografia',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.INTERNET.value,
    texto: 'internet',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FASHION.value,
    texto: 'moda',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.MUSIC.value,
    texto: 'música',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.RELIGION.value,
    texto: 'religião',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ROMANCE.value,
    texto: 'romance',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.HEALTH.value,
    texto: 'saúde',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SEX.value,
    texto: 'sexo',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TATTOO_PIERCING.value,
    texto: 'tatuagem e piercing',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TECHNOLOGY.value,
    texto: 'tecnologia',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.HORROR.value,
    texto: 'terror',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.JOB.value,
    texto: 'trabalho',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TRANSPORT.value,
    texto: 'transportes',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TV_MOVIES_SERIES.value,
    texto: 'tv, filmes e séries',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.VEHICLES.value,
    texto: 'veículos',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.LIFE_DEATH.value,
    texto: 'vida e morte',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.VIOLENCE.value,
    texto: 'violência',
    isDesabilitada: false,
    isSelecionar: true,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SHAME.value,
    texto: 'vergonha',
    isDesabilitada: false,
    isSelecionar: true,
  )
];

enum CategoriaEnum {
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
  BOOKMARK('bookmark'),
  SEX('sex'),
  SCIENCE('sciencie'),
  SPORTS('sports'),
  STUDIES('studies'),
  TATTOO_PIERCING('tattoo_piercing'),
  TECHNOLOGY('technology'),
  TRANSPORT('transport'),
  TV_MOVIES_SERIES('tv_movies_series'),
  VEHICLES('vehicles'),
  LIFE_DEATH('life_death'),
  VIOLENCE('violence'),
  SHAME('shame');

  final String value;
  const CategoriaEnum(this.value);
}

class CategoriaClass {
  String pegarTextoCategoria(String _item) {
    var categoria =
        listaCategoria.firstWhere((element) => element.idCategoria == _item);

    return categoria.texto;
  }

  List<CategoriaModel> filtrarPorCategoria() {
    return listaCategoria
        .where(
            (item) => item.isSelecionar == true && item.isDesabilitada == false)
        .toList();
  }

  bool isCategoriaSelecionada(List<String> listaSelecionado, String id) {
    return listaSelecionado.contains(id) ? true : false;
  }
}
