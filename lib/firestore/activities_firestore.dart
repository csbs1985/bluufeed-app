import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesFirestore {
  CollectionReference activities =
      FirebaseFirestore.instance.collection('activities');

  postActivity(Map<String, dynamic> _activity) {
    return activities.doc(_activity['id']).set(_activity);
  }
}
