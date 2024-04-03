class ServerException implements Exception {}

class DatabaseExp implements Exception {
  final String message;

  DatabaseExp(this.message);
}
