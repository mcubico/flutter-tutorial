import 'package:apifernando/app/data/services/auth_service.dart';
import 'package:apifernando/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:apifernando/app/ui/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ProductService()),
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
      initialRoute: 'checkAuth',
      routes: {
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const HomeScreen(),
        'productDetail': (context) => const ProductDetailScreen(),
        'checkAuth': (context) => const CheckAuthScreen(),
      },
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade300),
    );
  }
}
