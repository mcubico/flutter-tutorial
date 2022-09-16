import 'package:flutter/material.dart';
import 'package:apifernando/app/ui/views/views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'login': (context) => const LoginView(),
        'home': (context) => const HomeView(),
        'product': (context) => const ProductView(),
      },
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade300),
    );
  }
}
