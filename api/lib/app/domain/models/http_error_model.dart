class HttpErrorModel {
  final Object? exception;
  final StackTrace stackTrace;
  final dynamic data;

  HttpErrorModel({
    required this.exception,
    required this.stackTrace,
    required this.data,
  });
}
