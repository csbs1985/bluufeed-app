class BlockedModel {
  late String id;
  late String name;
  late String date;

  BlockedModel({
    required this.id,
    required this.name,
    required this.date,
  });

  factory BlockedModel.fromMap(Map<String, dynamic> json) => BlockedModel(
        id: json['id'],
        name: json['name'],
        date: json["date"],
      );

  Map<String, dynamic> toMap(BlockedModel user) => {
        'id': user.id,
        'name': user.name,
        'date': user.date,
      };
}
