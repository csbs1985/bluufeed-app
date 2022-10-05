class BlockService {
  final List<Map<String, dynamic>> _listBlocked = [];

  String getTextButton(Map<String, dynamic> _content) {
    if (_content['isSigned'] != null)
      return _content['isSigned']
          ? 'bloquear ${_content['userName'] ?? _content['name']}'
          : 'bloquear usuário';

    return 'bloquear ${_content['userName'] ?? _content['name']}';
  }

  bloquear() {}
}
