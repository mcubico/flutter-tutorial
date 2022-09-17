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

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // Constructors
  ProductService() {
    getAll();
  }

  // Public Methods
  Future getAll() async {
    isLoading = true;
    final url = Uri.https(_baseUlr, 'products.json');
    final response = await http.get(url);
    final List data = json.decode(response.body);

    for (var element in data) {
      if (element == null) continue;

      products.add(ProductModel.fromMap(element));
    }

    isLoading = false;
  }
}
