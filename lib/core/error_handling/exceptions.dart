class LanguageDataException implements Exception {
  final String message;

  LanguageDataException({required this.message});

  @override
  String toString() => message;
}

class HiveDataException implements Exception {
  final String message;

  HiveDataException({required this.message});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => message;
}

class AudioException implements Exception {
  final String message;

  const AudioException({required this.message});

  @override
  String toString() => message;
}
