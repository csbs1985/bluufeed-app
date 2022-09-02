import 'package:flutter/material.dart';

ValueNotifier<String> currentToken = ValueNotifier<String>('');

ValueNotifier<String> currentDialog = ValueNotifier<String>('');

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
