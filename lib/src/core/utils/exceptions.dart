class OAuthGrantException implements Exception {
  String message;

  OAuthGrantException({required this.message});

  @override
  String toString() {
    return "OAuthGrantException: $message";
  }
}
