class ServerException implements Exception {
  const ServerException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  const NetworkException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  const CacheException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  const ValidationException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'ValidationException: $message';
}

class UnknownException implements Exception {
  const UnknownException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'UnknownException: $message';
}
