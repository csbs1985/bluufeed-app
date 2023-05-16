class JustificarModel {
  final int idJustificar;
  final String titulo;
  final String texto;

  JustificarModel({
    required this.idJustificar,
    required this.titulo,
    required this.texto,
  });
}

final List<JustificarModel> listaJustificar = [
  JustificarModel(
    idJustificar: 0,
    titulo: 'Quero remover algo',
    texto: 'Quero remover todos conteúdo e recomeçar.',
  ),
  JustificarModel(
    idJustificar: 1,
    titulo: 'Problemas para começar',
    texto: 'Tive problema pra iniciar o uso.',
  ),
  JustificarModel(
    idJustificar: 2,
    titulo: 'Passo muito tempo aqui',
    texto: 'Perco muito tempo da minha vida neste app.',
  ),
  JustificarModel(
    idJustificar: 3,
    titulo: 'Não vejo motivo para usar o bluufeed',
    texto: 'Ainda não encontrei o motivo para utilizar o bluufeed.',
  ),
  JustificarModel(
    idJustificar: 4,
    titulo: 'Questões de privacidade',
    texto:
        'Estou deletando minha conta por motivos de privacidade, não me sinto seguro.',
  ),
  JustificarModel(
    idJustificar: 5,
    titulo: 'Usuários não respeitam as regras',
    texto: 'Alguns usuário não respeitam as regras e me sinto desconfortável.',
  ),
  JustificarModel(
    idJustificar: 6,
    titulo: 'Aplicação complicada de mexer',
    texto: 'Não consigo utilizar o app devido a sua complexidade.',
  ),
  JustificarModel(
    idJustificar: 7,
    titulo: 'Conteúdo pouco relevante',
    texto: 'Acredito que o conteúdo não seja relevante para mim.',
  ),
  JustificarModel(
    idJustificar: 8,
    titulo: 'Layout da aplicação confusa',
    texto: 'Me confundo ao utiliza-ló, muito difícil e confuso.',
  ),
  JustificarModel(
    idJustificar: 9,
    titulo: 'Outro motivo não listado',
    texto: 'Não encontrei aqui o motivo.',
  ),
];
