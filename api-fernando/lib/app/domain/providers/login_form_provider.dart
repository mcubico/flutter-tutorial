import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
