class CommonQuestionsModel {
  final String id;
  final String question;
  final String answer;

  CommonQuestionsModel(
      {required this.id, required this.question, required this.answer});

  static List<CommonQuestionsModel> allQuestions = [
    CommonQuestionsModel(
        id: '0',
        question: 'Por que não utilizamos fotos no perfil?',
        answer:
            'R: O bluufeed não tem o objetivo de deixar ninguém famoso ou divulgar seu perfil e sim contar histórias. E o anonimato pode encorajar algumas pessoas.'),
    CommonQuestionsModel(
      id: '1',
      question: 'Por que não podemos curtir o conteúdo?',
      answer:
          'R: Quando pensamos em criar o bluufeed uns dos pontos foi de fugir das características de uma rede social comum onde os usuários buscam aceitação e contam o número de curtidas. Queremos que seja um lugar onde qualquer um possa contar seus segredos e que seja seguro e discreto.',
    ),
    CommonQuestionsModel(
      id: '2',
      question:
          'Por que tem a opção de escrever histórias e comentário anônimo?',
      answer:
          'R: Porque queremos que o bluufeed seja um lugar onde qualquer um possa contar suas histórias e experiências sem o julgamento público, onde possa se identificar com outras pessoas e compartilhar suas dores, experiências, superações e contar como passou por tudo. E quem sabe ajudar ao proximo.',
    ),
    CommonQuestionsModel(
      id: '3',
      question: 'Por que não podemos marcar outros usuários?',
      answer:
          'R: Entendemos que assim não evita as discursões e conversar mais intensas. Caso queira compartilhar algo com alguém você pode enviar a história diretamente',
    ),
    CommonQuestionsModel(
      id: '4',
      question: 'Um usuário não esta cumprindo as regras, o que devo fazer?',
      answer:
          'R: Você pode denuncia-ló ou bloquea-ló. Na terceira denuncia o usuário será bloqueado e terá sua conta deletado do bluufeed. Bloqueando, vocês não poderão mais ver o conteúdo um do outro.',
    ),
    CommonQuestionsModel(
      id: '5',
      question: 'Recebi a segunda denuncia, e agora?',
      answer:
          'R: As denuncias servem para manter um controle e garantir que todos siga as regras. Na sua segunda denuncia você entra no alerta, porque na terceira denuncia sua conta e bloqueada e excluida de nossos servidores.',
    ),
  ];
}
