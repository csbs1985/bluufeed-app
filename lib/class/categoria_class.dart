class CategoriaModel {
  final String? idCategoria;
  final String? texto;
  final bool? isDesabilitada;

  CategoriaModel({
    this.idCategoria,
    this.texto,
    this.isDesabilitada,
  });
}

final List<CategoriaModel> listaCategoria = [
  CategoriaModel(
    idCategoria: CategoriaEnum.ALL.value,
    texto: 'todas',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ANIMALS.value,
    texto: 'animais',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ART.value,
    texto: 'arte',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ASTROLOY.value,
    texto: 'astrologia',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ASTRONOMY.value,
    texto: 'astronomia',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.DRINK.value,
    texto: 'bebidCategoriaa',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.BEAUTY.value,
    texto: 'beleza',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SCIENCE.value,
    texto: 'ciências',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.CLIMATE_WEATHER.value,
    texto: 'clima e tempo',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.COMEDY.value,
    texto: 'comédia',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FOOD.value,
    texto: 'comidCategoriaa',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.CULTURE.value,
    texto: 'cultura',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.MONEY.value,
    texto: 'dinheiro',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ENTERTAINMENT.value,
    texto: 'entretenimento',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SPORTS.value,
    texto: 'esportes',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.STUDIES.value,
    texto: 'estudos',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.EVENTS.value,
    texto: 'eventos',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.EXTRATERRESTRIAL.value,
    texto: 'extraterrestre',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FAMILY.value,
    texto: 'família',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FOLKLORE.value,
    texto: 'folclore',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.PHOTOGRAPHY_VidCategoriaEO.value,
    texto: 'fotografia e vídeos',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.GEOGRAPHY.value,
    texto: 'geografia',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.INTERNET.value,
    texto: 'internet',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.FASHION.value,
    texto: 'moda',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.MUSIC.value,
    texto: 'música',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.RELIGION.value,
    texto: 'religião',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.ROMANCE.value,
    texto: 'romance',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.HEALTH.value,
    texto: 'saúde',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SEX.value,
    texto: 'sexo',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TATTOO_PIERCING.value,
    texto: 'tatuagem e piercing',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TECHNOLOGY.value,
    texto: 'tecnologia',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.HORROR.value,
    texto: 'terror',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.JOB.value,
    texto: 'trabalho',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TRANSPORT.value,
    texto: 'transportes',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.TV_MOVIES_SERIES.value,
    texto: 'tv, filmes e séries',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.VEHICLES.value,
    texto: 'veículos',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.LIFE_DEATH.value,
    texto: 'vidCategoriaa e morte',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.VIOLENCE.value,
    texto: 'violência',
    isDesabilitada: false,
  ),
  CategoriaModel(
    idCategoria: CategoriaEnum.SHAME.value,
    texto: 'vergonha',
    isDesabilitada: false,
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
  PHOTOGRAPHY_VidCategoriaEO('photagraphy_vidCategoriaeo'),
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
  const CategoriaEnum(this.value);
}
