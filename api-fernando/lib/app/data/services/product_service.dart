import 'dart:convert';

import 'package:apifernando/app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  // Attributes
  final _baseUlr = 'bitcubico-fb-tutorial-default-rtdb.firebaseio.com';
  bool _isLoading = false;

  // Properties
  final List<ProductModel> products = [];
  late ProductModel? selectedProduct;

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // Constructors
  ProductService() {
    getAll();
  }

  // Methods
  Future getAll() async {
    print('Start: ProductService -> getAll');

    isLoading = true;
    final url = Uri.https(_baseUlr, 'products.json');
    final httpResponse = await http.get(url);
    final List data = json.decode(httpResponse.body);

    for (var element in data) {
      if (element == null) continue;

      products.add(ProductModel.fromMap(element));
    }

    isLoading = false;

    print('End: ProductService -> getAll');
  }

  Future updateOrCreateProduct(ProductModel product) async {
    print('Start: ProductService -> updateOrCreateProduct');

    isLoading = true;
    if (product.id == null)
      return;
    else
      await _updateProduct(product);

    isLoading = false;
    print('End: ProductService -> updateOrCreateProduct');
  }

  Future<String> _updateProduct(ProductModel product) async {
    print('Start: ProductService -> _updateProduct');

    final url = Uri.https(_baseUlr, 'products/${product.id}.json');
    final httpResponse = await http.put(url, body: product.toJson());
    final dataResponse = json.decode(httpResponse.body);

    _updateProductList(product);

    print('End: ProductService -> _updateProduct');
    return product.id!;
  }

  void _updateProductList(ProductModel product) {
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;
    notifyListeners();
  }
}
