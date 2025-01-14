class Env {
  static const Map<String, String> _keys = {
    'API_ENDPOINT': String.fromEnvironment('API_ENDPOINT'),
    'API_KEY': String.fromEnvironment('API_KEY'),
    'API_TOKEN': String.fromEnvironment('API_TOKEN'),
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key no está configurado en Env RLP');
    }
    return value;
  }

  static String get apiEndpoint => _getKey('API_ENDPOINT');
  static String get apiKey => _getKey('API_KEY');
  static String get apiToken => _getKey('API_TOKEN');
}
