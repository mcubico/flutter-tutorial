import 'package:api/app/domain/enumerators/enumerators.dart';

abstract class AuthenticationAbstractRepository {
  Future<String?> get accessToken;
  Future<HttpResponseEnum> login({
    required String email,
    required String password,
  });
}
