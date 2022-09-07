import 'package:flutter/material.dart';
import 'package:formularios/app/ui/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackgroundWidget(),
    );
  }
}
