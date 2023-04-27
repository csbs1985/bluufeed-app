import 'package:bluufeed_app/firestore/token_firebase.dart';

final TokenFirestore _tokenFirestore = TokenFirestore();

class TokenClass {
  Future<String> pegarToken() async {
    return await _tokenFirestore.pegarToken();
  }
}
