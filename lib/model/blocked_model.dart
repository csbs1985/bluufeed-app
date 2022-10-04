class BlockedModel {
  late String id;
  late String name;
  late String date;

  BlockedModel({
    required this.id,
    required this.name,
    required this.date,
  });

  factory BlockedModel.fromJson(Map<String, dynamic> json) =>
      BlockedModel.fromMap(json);

  factory BlockedModel.fromMap(Map<String, dynamic> json) => BlockedModel(
        id: json['id'],
        name: json['name'],
        date: json['date'],
      );
}
