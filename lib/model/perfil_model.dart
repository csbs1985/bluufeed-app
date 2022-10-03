import 'package:bluuffed_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<UserModel>> currentPerfil =
    ValueNotifier<List<UserModel>>([]);

class PerfilClass {
  void add(Map<String, dynamic> user) {
    currentPerfil.value = [];
    currentPerfil.value.add(UserModel.fromJson(user));
  }
}
