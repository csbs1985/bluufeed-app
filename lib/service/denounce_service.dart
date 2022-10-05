class DenounceService {
  String getTextButton(Map<String, dynamic> _content) {
    if (_content['isSigned'] != null)
      return _content['isSigned']
          ? 'denunciar ${_content['userName'] ?? _content['name']}'
          : 'denunciar usuário';

    return 'denunciar ${_content['userName'] ?? _content['name']}';
  }
}
