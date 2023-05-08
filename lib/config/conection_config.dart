import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionConfig extends ChangeNotifier {
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  ConnectionConfig() {
    _checkConnection();
    InternetConnectionChecker().onStatusChange.listen((status) {
      _isConnected = status == InternetConnectionStatus.connected;
      notifyListeners();
    });
  }

  Future<void> _checkConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }
}
