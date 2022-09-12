import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityFirestore {
  CollectionReference activities =
      FirebaseFirestore.instance.collection('activities');

  postActivity(Map<String, dynamic> _activity) async {
    return await activities.doc(_activity['id']).set(_activity);
  }
}
