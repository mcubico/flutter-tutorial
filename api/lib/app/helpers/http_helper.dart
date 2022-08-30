import 'dart:convert';

import 'package:api/app/helpers/helpers.dart';
import 'package:api/app/models/models.dart';
import 'package:http/http.dart';

typedef Parser<T> = T Function(dynamic data);

class HttpHelper {
  final String baseUrl;

  HttpHelper(this.baseUrl);

  Future<HttpResultModel<T>> request<T>(
    String endpoint, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    dynamic body,
    Parser<T>? parser,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    late int? statusCode;
    late dynamic data;

    try {
      final Uri url = _makeUrl(endpoint, queryParameters);
      final response = await sendRequest(
        url: url,
        method: method,
        headers: headers,
        body: body,
        timeout: timeout,
      );

      data = _parseBody(response.body);
      statusCode = response.statusCode;

      if (statusCode >= 400) {
        throw HttpErrorModel(
          exception: null,
          stackTrace: StackTrace.current,
          data: data,
        );
      }

      return HttpResultModel<T>(
          data: parser != null ? parser(data) : data,
          statusCode: statusCode,
          error: null);
    } catch (exception, stackTrace) {
      if (exception is HttpErrorModel) {
        return HttpResultModel<T>(
          data: null,
          statusCode: statusCode!,
          error: exception,
        );
      }

      // Se presentó un error en la comunicación con el servidor
      return HttpResultModel<T>(
        data: data,
        error: HttpErrorModel(
          exception: exception,
          stackTrace: stackTrace,
          data: data,
        ),
        statusCode: -1,
      );
    }
  }

  Uri _makeUrl(String endpoint, Map<String, String> queryParameters) {
    late Uri url;

    if (_urlContainHttpOrHttps(endpoint)) {
      url = Uri.parse(endpoint);
    } else {
      url = Uri.parse('$baseUrl$endpoint');
    }

    if (queryParameters.isNotEmpty) {
      url = url.replace(
        queryParameters: {...url.queryParameters, ...queryParameters},
      );
    }

    return url;
  }

  bool _urlContainHttpOrHttps(String endpoint) =>
      endpoint.startsWith('http://') || endpoint.startsWith('https://');

  static Future<Response> sendRequest({
    required Uri url,
    required HttpMethod method,
    required Map<String, String> headers,
    required dynamic body,
    required Duration timeout,
  }) {
    // Como los headers son de tipo Map y este es no modificable, entonces
    // crearé una copia de los headers para poder modificarlo más adelante
    final headersAux = {...headers};
    late Client client;

    if (method != HttpMethod.get) {
      final contentType = headersAux['Content-type'];

      if (contentType == null || contentType.contains('application/json')) {
        headersAux['Content-type'] = 'application/json; charset=UTF-8';
        body = _parseBody(body);
      }
    }

    client = Client();
    switch (method) {
      case HttpMethod.get:
        return client.get(url, headers: headersAux).timeout(timeout);
      case HttpMethod.post:
        return client
            .post(url, headers: headersAux, body: body)
            .timeout(timeout);
      case HttpMethod.put:
        return client
            .put(url, headers: headersAux, body: body)
            .timeout(timeout);
      case HttpMethod.patch:
        return client
            .patch(url, headers: headersAux, body: body)
            .timeout(timeout);
      case HttpMethod.delete:
        return client
            .delete(url, headers: headersAux, body: body)
            .timeout(timeout);
    }
  }

  static dynamic _parseBody(dynamic body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }
}
