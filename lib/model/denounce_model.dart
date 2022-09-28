class DenounceJustifyModel {
  DenounceJustifyModel({
    required this.id,
    required this.title,
    required this.text,
  });

  late String id;
  late String title;
  late String text;

  static List<DenounceJustifyModel> allDenounceJustify = [
    DenounceJustifyModel(id: "0", title: "Fingindo ser outra pessoa", text: ""),
    DenounceJustifyModel(id: "1", title: "Conta falsa", text: ""),
    DenounceJustifyModel(id: "2", title: "Suicídio ou automotilação", text: ""),
    DenounceJustifyModel(id: "3", title: "Conteúdo inadequado", text: ""),
    DenounceJustifyModel(id: "4", title: "Assédio moral", text: ""),
    DenounceJustifyModel(id: "5", title: "Assédio sexual", text: ""),
    DenounceJustifyModel(id: "6", title: "Bullying", text: ""),
    DenounceJustifyModel(id: "7", title: "Quero ajudar alguém", text: ""),
    DenounceJustifyModel(id: "8", title: "Span", text: ""),
    DenounceJustifyModel(id: "9", title: "Terrorismo", text: ""),
    DenounceJustifyModel(id: "10", title: "Discurso de ódio", text: ""),
    DenounceJustifyModel(id: "11", title: "Venda não autorizada", text: ""),
    DenounceJustifyModel(id: "14", title: "Outra coisa", text: "")
  ];
}
