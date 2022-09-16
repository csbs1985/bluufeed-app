import 'package:flutter/cupertino.dart';

ValueNotifier<String> currentForm = ValueNotifier<String>('');

enum FormEnum {
  CREATE('cretae'),
  EDIT('edit'),
  LOGIN('login'),
  REGISTER('register'),
  FORGOT('forgot'),
  NULL('');

  final String value;
  const FormEnum(this.value);
}
