class JustifyModel {
  final String id;
  final String title;
  final String text;

  JustifyModel({
    required this.id,
    required this.title,
    required this.text,
  });

  static List<JustifyModel> allJustify = [
    JustifyModel(
      id: '0',
      title: 'Quero remover algo',
      text: 'Quero remover todos conteúdo e recomeçar.',
    ),
    JustifyModel(
      id: '1',
      title: 'Problemas para começar',
      text: 'Tive problema pra iniciar o uso.',
    ),
    JustifyModel(
      id: '2',
      title: 'Passo muito tempo aqui',
      text: 'Perco muito tempo da minha vida neste app.',
    ),
    JustifyModel(
      id: '3',
      title: 'Não vejo motivo para usar o History',
      text: 'Ainda não encontrei o motivo para utilizar o History.',
    ),
    JustifyModel(
      id: '4',
      title: 'Questões de privacidade',
      text:
          'Estou deletando minha conta por motivos de privacidade, não me sinto seguro.',
    ),
    JustifyModel(
      id: '5',
      title: 'Usuários não respeitam as regras',
      text: 'Alguns usuário não respeitam as regras e me sinto desconfortável.',
    ),
    JustifyModel(
      id: '6',
      title: 'Aplicação complicada de mexer',
      text: 'Não consigo utilizar o app devido a sua complexidade.',
    ),
    JustifyModel(
      id: '7',
      title: 'Conteúdo pouco relevante',
      text: 'Acredito que o conteúdo não seja relevante para mim.',
    ),
    JustifyModel(
      id: '8',
      title: 'Layout da aplicação confusa',
      text: 'Me confundo ao utiliza-ló, muito difícil e confuso.',
    ),
    JustifyModel(
      id: '9',
      title: 'Outro motivo não listado',
      text: 'Não encontrei aqui o motivo.',
    ),
  ];
}
