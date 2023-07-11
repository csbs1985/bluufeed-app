import 'package:eight_app/config/constant_config.dart';

class DeletarContaModel {
  final int idDeletarConta;
  final String titulo;
  final String texto;

  DeletarContaModel({
    required this.idDeletarConta,
    required this.titulo,
    required this.texto,
  });
}

final List<DeletarContaModel> listaDeletarConta = [
  DeletarContaModel(
    idDeletarConta: 0,
    titulo: CANCELAR,
    texto: 'Cancelar e seguir com sua conta Eight.',
  ),
  DeletarContaModel(
    idDeletarConta: 1,
    titulo: SAIR,
    texto: SAIR_DESCRICAO,
  ),
  DeletarContaModel(
    idDeletarConta: 2,
    titulo: JUSTIFICAR,
    texto: 'Antes me diga o motivo do porque esta deletando sua conta Eight.',
  ),
  DeletarContaModel(
    idDeletarConta: 3,
    titulo: 'Deletar',
    texto: 'Apenas deletar a conta.',
  ),
];

enum DeletarContaEnum {
  CANCELAR(0),
  SAIR(1),
  JUSTIFICAR(2),
  DELETAR(3);

  final int value;
  const DeletarContaEnum(this.value);
}

class DeletarContaClass {}
