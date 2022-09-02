import 'package:firebase_messaging/firebase_messaging.dart';

class TokenFirestore {
  Future<String?> token = FirebaseMessaging.instance.getToken();

  getToken() {
    return token;
  }
}
