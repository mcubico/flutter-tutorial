import 'package:apifernando/app/domain/models/models.dart';
import 'package:flutter/material.dart';

class ProductDetailFormProvider extends ChangeNotifier {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  ProductModel product;

  ProductDetailFormProvider({required this.product});

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
