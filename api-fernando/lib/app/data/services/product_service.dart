import 'dart:convert';
import 'dart:io';

import 'package:apifernando/app/data/services/services.dart';
import 'package:apifernando/app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  // Attributes
  final _baseUlr = 'bitcubico-fb-tutorial-default-rtdb.firebaseio.com';
  bool _isLoading = false;
  final _storage = FlutterSecureStorage();

  // Properties
  File? pictureToUpdate;
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
    final url = Uri.https(
      _baseUlr,
      'products.json',
      {'auth': await _getToken()},
    );
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

  Future<String> _getToken() async =>
      await _storage.read(key: AuthService.tokenKeyName) ?? '';

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

    final url = Uri.https(
      _baseUlr,
      'products/${product.id}.json',
      {'auth': await _getToken()},
    );
    final httpResponse = await http.put(url, body: product.toJson());
    final dataResponse = json.decode(httpResponse.body);

    _updateProductList(product);

    print('End: ProductService -> _updateProduct');
    return product.id!;
  }

  Future<String> _createProduct(ProductModel product) async {
    print('Start: ProductService -> _createProduct');

    final url = Uri.https(
      _baseUlr,
      'products.json',
      {'auth': await _getToken()},
    );
    final httpResponse = await http.post(url, body: product.toJson());
    final dataResponse = json.decode(httpResponse.body);

    product.id = dataResponse['name'];
    _updateProductList(product);

    print('End: ProductService -> _createProduct');
    return product.id!;
  }

  void _updateProductList(ProductModel product) {
    print('Start: ProductService -> _updateProductList');

    final index = products.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      products[index] = product;
    } else {
      products.add(product);
    }

    notifyListeners();

    print('End: ProductService -> _updateProductList');
  }

  Future<String?> uploadPicture() async {
    if (pictureToUpdate == null) return null;

    print('Start: ProductService -> uploadPicture');

    isLoading = true;
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dpyy1u2we/image/upload?api_key=793363257913693&upload_preset=tuto-flutter');

    final file =
        await http.MultipartFile.fromPath('file', pictureToUpdate!.path);

    final imageUploadRequest = http.MultipartRequest('POST', url);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final httpResponse = await http.Response.fromStream(streamResponse);

    if (httpResponse.statusCode != HttpStatus.ok) return null;

    final dataResponse = json.decode(httpResponse.body);

    pictureToUpdate = null;
    isLoading = false;

    print('End: ProductService -> uploadPicture');
    return dataResponse['secure_url'];
  }

  void updateSelectedProductPicture(String path) {
    selectedProduct?.picture = path;
    pictureToUpdate = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
