import 'package:api/app/domain/models/models.dart';

class HttpResultModel<T> {
  final T? data;
  final int statusCode;
  final HttpErrorModel? error;

  HttpResultModel({
    required this.data,
    required this.statusCode,
    required this.error,
  });
}
