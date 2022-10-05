class BlockedModel {
  late String idUser;
  late String nameUser;
  late String date;
  late bool isBlocker;

  BlockedModel({
    required this.idUser,
    required this.nameUser,
    required this.date,
    required this.isBlocker,
  });

  factory BlockedModel.fromMap(Map<String, dynamic> json) => BlockedModel(
        idUser: json['idUser'],
        nameUser: json['nameUser'],
        date: json['date'],
        isBlocker: json['isBlocker'],
      );

  Map<String, dynamic> toMap(BlockedModel user) => {
        'idUser': user.idUser,
        'nameUser': user.nameUser,
        'date': user.date,
        'isBlocker': user.isBlocker,
      };
}
