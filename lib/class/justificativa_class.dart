import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/firestore/justificar_firestore.dart';
import 'package:uuid/uuid.dart';

class JustificativaModel {
  late String idJustificativa;
  late String titulo;
  late String texto;

  JustificativaModel({
    required this.idJustificativa,
    required this.titulo,
    required this.texto,
  });

  static List<JustificativaModel> listaJustificativa = [
    JustificativaModel(
      idJustificativa: '0',
      titulo: 'Quero remover algo',
      texto: 'Quero remover todos conteúdo e recomeçar.',
    ),
    JustificativaModel(
      idJustificativa: '1',
      titulo: 'Problemas para começar',
      texto: 'Tive problema pra iniciar o uso.',
    ),
    JustificativaModel(
      idJustificativa: '2',
      titulo: 'Passo muito tempo aqui',
      texto: 'Perco muito tempo da minha vida neste app.',
    ),
    JustificativaModel(
      idJustificativa: '3',
      titulo: 'Não vejo motivo para usar o Eight',
      texto: 'Ainda não encontrei o motivo para utilizar o Eight.',
    ),
    JustificativaModel(
      idJustificativa: '4',
      titulo: 'Questões de privacidade',
      texto:
          'Estou deletando minha conta por motivos de privacidade, não me sinto seguro.',
    ),
    JustificativaModel(
      idJustificativa: '5',
      titulo: 'Usuários não respeitam as regras',
      texto:
          'Alguns usuário não respeitam as regras e me sinto desconfortável.',
    ),
    JustificativaModel(
      idJustificativa: '6',
      titulo: 'Aplicação complicada de mexer',
      texto: 'Não consigo utilizar o app devido a sua complexidade.',
    ),
    JustificativaModel(
      idJustificativa: '7',
      titulo: 'Conteúdo pouco relevante',
      texto: 'Acredito que o conteúdo não seja relevante para mim.',
    ),
    JustificativaModel(
      idJustificativa: '8',
      titulo: 'Layout da aplicação confusa',
      texto: 'Me confundo ao utiliza-ló, muito difícil e confuso.',
    ),
    JustificativaModel(
      idJustificativa: '9',
      titulo: 'Outro motivo não listado',
      texto: 'Não encontrei aqui o motivo.',
    ),
  ];
}

class JustificarClass {
  final JustificarFirestore _justificarFirestore = JustificarFirestore();
  final Uuid uuid = const Uuid();

  postJustificar(int idJustificar) {
    Map<String, dynamic> _justificar = {
      'idJustificacao': uuid.v4(),
      'dataRegistro': DateTime.now().toString(),
      'idUsuario': currentUsuario.value.idUsuario,
      'idJustificar': idJustificar,
    };

    _justificarFirestore.postJustificar(_justificar);
  }
}
