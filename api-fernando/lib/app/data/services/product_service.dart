import 'dart:convert';
import 'dart:io';

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
  late File? pictureToUpdate;

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
    final Map<String, dynamic> data = json.decode(httpResponse.body);

    data.forEach((key, value) {
      ProductModel product = ProductModel.fromMap(value);
      product.id = key;
      products.add(product);
    });

    isLoading = false;

    print('End: ProductService -> getAll');
  }

  Future updateOrCreateProduct(ProductModel product) async {
    print('Start: ProductService -> updateOrCreateProduct');

    isLoading = true;
    if (product.id == null) {
      await _createProduct(product);
    } else {
      await _updateProduct(product);
    }

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

  Future<String> _createProduct(ProductModel product) async {
    print('Start: ProductService -> _createProduct');

    final url = Uri.https(_baseUlr, 'products.json');
    final httpResponse = await http.post(url, body: product.toJson());
    final dataResponse = json.decode(httpResponse.body);

    product.id = dataResponse['name'];
    _updateProductList(product);

    print('End: ProductService -> _createProduct');
    return product.id!;
  }

  void _updateProductList(ProductModel product) {
    final index = products.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      products[index] = product;
    } else {
      products.add(product);
    }

    notifyListeners();
  }

  void updateSelectedProductPicture(String path) {
    selectedProduct?.picture = path;
    pictureToUpdate = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
