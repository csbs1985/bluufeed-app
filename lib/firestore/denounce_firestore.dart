import 'package:cloud_firestore/cloud_firestore.dart';

class DenounceFirestore {
  CollectionReference denounceis =
      FirebaseFirestore.instance.collection('denounceis');

  postDenounce(Map<String, dynamic> _form) {
    return denounceis.doc(_form['id']).set(_form);
  }
}
