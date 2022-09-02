import 'package:cloud_firestore/cloud_firestore.dart';

class NotificatonsFirestore {
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  pathNotificationView(String _notificationId) {
    return notifications.doc(_notificationId).update({'view': true});
  }

  postNotification(Map<String, dynamic> _notification) {
    return notifications.doc(_notification['id']).set(_notification);
  }
}
