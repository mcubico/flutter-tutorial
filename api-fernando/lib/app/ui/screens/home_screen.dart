import 'package:apifernando/app/data/services/product_service.dart';
import 'package:apifernando/app/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:apifernando/app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: productService.products.length,
          itemBuilder: (context, index) => GestureDetector(
            child: ProductCardWidget(
              product: productService.products[index],
            ),
            onTap: () => Navigator.pushNamed(context, 'product'),
          ),
        ));
  }
}
