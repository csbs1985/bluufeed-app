import 'package:cloud_firestore/cloud_firestore.dart';

class JustificationsFirestore {
  CollectionReference justifications =
      FirebaseFirestore.instance.collection('justifications');

  postJustify(Map<String, dynamic> _form) {
    return justifications.doc(_form['id']).set(_form);
  }
}
