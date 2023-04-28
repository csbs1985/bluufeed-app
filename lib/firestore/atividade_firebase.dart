import 'package:cloud_firestore/cloud_firestore.dart';

class AtividadeFirestore {
  CollectionReference atividades =
      FirebaseFirestore.instance.collection('atividades');

  postActivity(Map<String, dynamic> _atividade) async {
    return await atividades.doc(_atividade['id']).set(_atividade);
  }
}
