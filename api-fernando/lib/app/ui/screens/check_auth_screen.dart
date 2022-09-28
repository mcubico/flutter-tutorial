import 'package:apifernando/app/data/services/services.dart';
import 'package:apifernando/app/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.getToken(),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (!snapshot.hasData) {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
