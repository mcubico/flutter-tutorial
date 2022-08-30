import 'package:api/app/data/services/authentication_service.dart';
import 'package:api/app/domain/enumerators/enumerators.dart';
import 'package:api/app/domain/repositories/repositories.dart';

class AuthenticationRepository implements AuthenticationAbstractRepository {
  final AuthenticationService _api;

  AuthenticationRepository(this._api);

  @override
  Future<String?> get accessToken async {
    await Future.delayed(const Duration(seconds: 1));
    return 'null';
  }

  @override
  Future<HttpResponseEnum> login({
    required String email,
    required String password,
  }) {
    return _api.login(email: email, password: password);
  }
}
