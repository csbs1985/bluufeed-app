import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String code,
  }) async {
    const serviceId = 'service_18ko0dn';
    const templateId = 'template_mfblzo6';
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
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': 'History - Código de verificação',
          'user_message': 'message',
          'to_email': email,
          'code': code,
        }
      }),
    );
  }
}
