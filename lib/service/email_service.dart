import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bluuffed_app/firestore/user_firestore.dart';

ValueNotifier<String> currentEmail = ValueNotifier<String>('');

class EmailService {
  final UserFirestore userFirestore = UserFirestore();

  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool alreadyEmail = false;

  Future sendEmail({
    required String email,
    required String subject,
    required String code,
    required String name,
    required String template,
  }) async {
    const serviceId = 'service_18ko0dn';
    const userId = 'zEFXfZTMn6WsFLO0U';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': template,
        'user_id': userId,
        'template_params': {
          'user_email': email,
          'user_subject': subject,
          'user_name': name,
          'to_email': email,
          'code': code,
        }
      }),
    );
  }

  validateEmail(String _type, String value) {
    if (value.isEmpty) return 'informe seu email';
    if (!RegExp(_regx).hasMatch(value)) return 'email informado não é válido';
    if (_type == EmailEnum.LOGIN.value) {
      if (!getEmail(value)) return 'email informado não encontrado';
    } else {
      if (getEmail(value)) return 'email informado já cadastrado';
    }
    return null;
  }

  bool getEmail(String value) {
    userFirestore
        .getUserEmail(value)
        .then((result) => alreadyEmail = result.size > 0 ? true : false)
        .catchError((error) => debugPrint('ERROR => _checkEmail: ' + error));

    return alreadyEmail;
  }
}

enum EmailEnum {
  LOGIN('login'),
  REGISTER('register');

  final String value;
  const EmailEnum(this.value);
}

enum EmailJsEnum {
  CODE('template_mfblzo6'),
  EMAIL('template_c0ch3cl');

  final String value;
  const EmailJsEnum(this.value);
}
