class FollowingModel {
  late String id;
  late String name;
  late String date;

  FollowingModel({
    required this.id,
    required this.name,
    required this.date,
  });

  factory FollowingModel.fromJson(json) => FollowingModel.fromMap(json);

  factory FollowingModel.fromMap(json) => FollowingModel(
        id: json['id'],
        name: json['name'],
        date: json['date'],
      );
}
