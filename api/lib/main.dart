import 'package:api/app/data/helpers/helpers.dart';
import 'package:api/app/data/repositories/repositories.dart';
import 'package:api/app/data/services/services.dart';
import 'package:api/app/domain/repositories/repositories.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TempPage());
}

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  void initState() {
    super.initState();

    final http = HttpHelper('https://reqres.in');
    final AuthenticationAbstractRepository auth = AuthenticationRepository(
      AuthenticationService(http),
    );

    auth
        .login(email: 'eve.holt@reqres.in', password: 'cityslicka')
        .then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
