class DeleteAccountModel {
  final String id;
  final String title;
  final String text;

  DeleteAccountModel({
    required this.id,
    required this.title,
    required this.text,
  });

  static List<DeleteAccountModel> allDeleteAccount = [
    DeleteAccountModel(
      id: '0',
      title: 'Cancelar',
      text: 'Cancelar e seguir com sua conta History.',
    ),
    DeleteAccountModel(
      id: '1',
      title: 'Desativar temporariamente',
      text:
          'Dar uma tempo e manter meu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta Apple ou Google cadastrada.',
    ),
    DeleteAccountModel(
      id: '2',
      title: 'Justificar e deletar',
      text:
          'Antes me diga o motivo do porque esta deletando sua conta History.',
    ),
    DeleteAccountModel(
      id: '3',
      title: 'Deletar',
      text: 'Apenas deletar sua conta.',
    ),
  ];
}
