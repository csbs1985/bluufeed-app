import 'package:bluufeed_app/firestore/token_firestore.dart';

final TokenFirestore _tokenFirestore = TokenFirestore();

class TokenClass {
  Future<String> pegarToken() async {
    return await _tokenFirestore.pegarToken();
  }
}
