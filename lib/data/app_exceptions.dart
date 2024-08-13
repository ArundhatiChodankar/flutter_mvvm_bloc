class AppException implements Exception {
  final String prefix;
  final String? message;

  AppException(this.prefix, [this.message]);

  @override
  String toString() {
    return message == null ? prefix : '$prefix: $message';
  }
}

class InternetException extends AppException {
  InternetException([String? message])
      : super("No Internet Connection", message);
}

class ServerTimeoutException extends AppException {
  ServerTimeoutException([String? message])
      : super("Server Timeout", message);
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super("Bad Request", message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super("Invalid Input", message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super("Unauthorized", message);
}
