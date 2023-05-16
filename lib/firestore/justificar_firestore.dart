import 'package:cloud_firestore/cloud_firestore.dart';

class JustificarFirestore {
  CollectionReference justificar =
      FirebaseFirestore.instance.collection('justificar');

  postJustificar(Map<String, dynamic> _justificar) {
    return justificar.doc(_justificar['idJustificacao']).set(_justificar);
  }
}
