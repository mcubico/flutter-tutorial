import 'package:apifernando/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:apifernando/app/ui/views/views.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductService(),
        )
      ],
      child: const MyApp(),
    );
  }
}

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
