import 'package:apifernando/app/data/services/auth_service.dart';
import 'package:apifernando/app/data/services/product_service.dart';
import 'package:apifernando/app/domain/models/models.dart';
import 'package:apifernando/app/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:apifernando/app/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();
              Navigator.of(context).pushReplacementNamed('checkAuth');
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          child: ProductCardWidget(
            product: productService.products[index],
          ),
          onTap: () {
            productService.selectedProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'productDetail');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.selectedProduct = ProductModel(
            available: true,
            name: '',
            description: '',
            price: 0,
          );
          Navigator.pushNamed(context, 'productDetail');
        },
      ),
    );
  }
}
