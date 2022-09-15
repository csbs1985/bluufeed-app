import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/model/activity_model.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

ValueNotifier<String> currentEmail = ValueNotifier<String>('');
ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);

class UserModel {
  late String id;
  late String name;
  late String upDateName;
  late String date;
  late String email;
  late String token;
  late String status;
  late bool isNotification;
  late num qtyHistory;
  late num qtyComment;

  UserModel({
    required this.id,
    required this.name,
    required this.upDateName,
    required this.date,
    required this.status,
    required this.email,
    required this.token,
    required this.isNotification,
    required this.qtyHistory,
    required this.qtyComment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        upDateName: json['upDateName'],
        date: json["date"],
        email: json['email'],
        token: json['token'],
        status: json['status'],
        isNotification: json['isNotification'],
        qtyHistory: json['qtyHistory'],
        qtyComment: json['qtyComment'],
      );

  static String toJson(UserModel user) => jsonEncode(toMap(user));

  static Map<String, dynamic> toMap(UserModel user) => {
        'id': user.id,
        'name': user.name,
        'upDateName': user.upDateName,
        'date': user.date,
        'email': user.email,
        'token': user.token,
        'isNotification': user.isNotification,
        'status': user.status,
        'qtyHistory': user.qtyHistory,
        'qtyComment': user.qtyComment,
      };
}

class UserClass {
  final ActivityClass activityClass = ActivityClass();
  final AuthService authService = AuthService();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  void add(Map<String, dynamic> user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(user));
    saveUser();
  }

  Future<File> saveUser() async {
    String data = UserModel.toJson(currentUser.value.first);
    final file = await getFileUser();
    return file.writeAsString(data);
  }

  Future<void> clean(BuildContext context) async {
    try {
      // await userFirestore.pathLoginLogout(UserStatusEnum.INACTIVE.name);
      await authService.logout();
      // activityClass.save(
      //   ActivityEnum.LOGOUT.value,
      //   DeviceModel(),
      //   '',
      // );
      currentUser.value = [];
      toast.toast(
        context,
        ToastEnum.SUCCESS.name,
        'espero que isso não seja um adeus!',
      );
    } catch (error) {
      debugPrint('ERROR => _setUpQtyHistoryUser:$error');
      toast.toast(context, ToastEnum.WARNING.name,
          'não foi possível sair da aplicação no momento, tente novamente mais tarde.');
    }
  }

  Future<void> delete(BuildContext context) async {
    try {
      await userFirestore.pathLoginLogout(UserStatusEnum.DELETED.name);
      await userFirestore.deleteUser();
      await authService.delete();
      currentUser.value = [];
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteUser: $error');
      Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.WARNING.name,
        'não foi possível delatar a conta no momento, tente novamente mais tarde.',
      );
    }
  }

  Future<String> readUser() async {
    final file = await getFileUser();
    return file.readAsString();
  }

  Future<File> getFileUser() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user.json');
  }

  bool isLogin() {
    return currentUser.value.isNotEmpty ? true : false;
  }
}

enum UserStatusEnum {
  ACTIVE('active'),
  INACTIVE('inactive'),
  DISABLED('disabled'),
  DELETED('deleted');

  final String value;
  const UserStatusEnum(this.value);
}
