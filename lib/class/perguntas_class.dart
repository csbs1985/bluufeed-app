class PerguntasModel {
  final String idPergunta;
  final String pergunta;
  final String resposta;

  PerguntasModel({
    required this.idPergunta,
    required this.pergunta,
    required this.resposta,
  });
}

final List<PerguntasModel> listaPerguntas = [
  PerguntasModel(
    idPergunta: '0',
    pergunta: 'Recebi a segunda denuncia, e agora?',
    resposta:
        'R: As denuncias servem para manter um controle e garantir que todos siga as regras. Na sua segunda denuncia você entra no alerta, porque na terceira denuncia sua conta e bloqueada e excluidPerguntaa de nossos servidPerguntaores.',
  ),
  PerguntasModel(
    idPergunta: '1',
    pergunta: 'Por que não podemos curtir o conteúdo?',
    resposta:
        'R: Quando pensamos em criar o Eight uns dos pontos foi de fugir das características de uma rede social comum onde os usuários buscam aceitação e contam o número de curtidPerguntaas. Queremos que seja um lugar onde qualquer um possa contar seus segredos e que seja seguro e discreto.',
  ),
  PerguntasModel(
    idPergunta: '2',
    pergunta: 'Por que tem a opção de escrever histórias e comentário anônimo?',
    resposta:
        'R: Porque queremos que o Eight seja um lugar onde qualquer um possa contar suas histórias e experiências sem o julgamento público, onde possa se idPerguntaentificar com outras pessoas e compartilhar suas dores, experiências, superações e contar como passou por tudo. E quem sabe ajudar ao proximo.',
  ),
  PerguntasModel(
    idPergunta: '3',
    pergunta: 'Por que não podemos marcar outros usuários?',
    resposta:
        'R: Entendemos que assim não evita as discursões e conversar mais intensas. Caso queira compartilhar algo com alguém você pode enviar a história diretamente',
  ),
  PerguntasModel(
    idPergunta: '4',
    pergunta: 'Um usuário não esta cumprindo as regras, o que devo fazer?',
    resposta:
        'R: Você pode denuncia-ló ou bloquea-ló. Na terceira denuncia o usuário será bloqueado e terá sua conta deletado do Eight. Bloqueando, vocês não poderão mais ver o conteúdo um do outro.',
  ),
];
