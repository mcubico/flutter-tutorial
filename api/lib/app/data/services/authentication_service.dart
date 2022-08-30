import 'dart:async';
import 'dart:io';

import 'package:api/app/data/helpers/helpers.dart';
import 'package:api/app/domain/enumerators/enumerators.dart';
import 'package:api/app/domain/models/models.dart';

class AuthenticationService {
  final HttpHelper _http;

  AuthenticationService(this._http);

  Future<HttpResponseEnum> login({
    required String email,
    required String password,
  }) async {
    final response = await _http.request<LoginModel>(
      '/api/login',
      method: HttpMethodEnum.post,
      body: {
        'email': email,
        'password': password,
      },
      parser: (data) {
        return LoginModel(data['token']);
      },
      queryParameters: {
        'delay': '3',
      },
    );

    print('Result object type: ${response.data}');
    print('Result data runtimeType: ${response.data.runtimeType}');
    print('Result statusCode: ${response.statusCode}');
    print('Result access token: ${response.data?.accessToken}');

    final error = response.error;
    if (error == null) return HttpResponseEnum.ok;

    if (response.statusCode == 400) return HttpResponseEnum.accessDenied;

    print('Result error: $error');
    print('Result error data: ${error.data}');
    print('Result error exception: ${error.exception}');
    print('Result error stacktrace: ${error.stackTrace}');

    final exception = error.exception;
    if (exception is SocketException || exception is TimeoutException) {
      return HttpResponseEnum.networkError;
    }

    return HttpResponseEnum.unknownError;
  }
}
