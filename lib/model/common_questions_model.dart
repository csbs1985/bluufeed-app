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
            'R: O History não tem o objetivo de deixar ninguém famoso ou divulgar seu perfil e sim contar historias. E o'
            ' anonimato pode encorajar algumas delas.'),
    CommonQuestionsModel(
      id: '1',
      question: 'Por que não podemos curtir e compartilhar conteúdo?',
      answer:
          'R: Quando pensamos em criar o History uns dos pontos foi de fugir das características de uma rede social comum'
          ' onde os usuários buscam aceitação e contam o número de curtidas e compartilhamentos. Queremos que seja um'
          ' lugar onde qualquer um conte seus segredos e que seja seguro e discreto.',
    ),
    CommonQuestionsModel(
      id: '2',
      question:
          'Por que tem a opção de escrever histórias e comentário anônimo?',
      answer:
          'R: Porque queremos que o History seja um lugar onde qualquer um possa contar suas histórias e experiências'
          ' sem o julgamento público, onde possa se identificar com outras pessoas e compartilhar suas dores,'
          ' experiências, superações e contar como passou por tudo aquilo. E quem sabe ajudar ao proximo.',
    ),
  ];
}
