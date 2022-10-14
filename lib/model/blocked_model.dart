class BlockedModel {
  late String blockedUserId;
  late String blockedUserName;
  late String blockingUser;
  late String date;

  BlockedModel({
    required this.blockedUserId,
    required this.blockedUserName,
    required this.blockingUser,
    required this.date,
  });

  factory BlockedModel.fromMap(Map<String, dynamic> json) => BlockedModel(
        blockedUserId: json['blockedUserId'],
        blockedUserName: json['blockedUserName'],
        blockingUser: json['blockingUser'],
        date: json['date'],
      );

  Map<String, dynamic> toMap(BlockedModel user) => {
        'blockedUserId': user.blockedUserId,
        'blockedUserName': user.blockedUserName,
        'blockingUser': user.blockingUser,
        'date': user.date,
      };
}
