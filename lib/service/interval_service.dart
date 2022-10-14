import 'dart:async';
import 'package:flutter/cupertino.dart';

class IntervalService {
  back(BuildContext context) {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) => Navigator.pop(context));
  }
}
