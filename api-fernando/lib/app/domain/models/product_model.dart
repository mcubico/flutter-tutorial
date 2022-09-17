import 'dart:convert';

class ProductModel {
  final String? id;
  final bool available;
  final String name;
  final String description;
  final String? picture;
  final double price;

  static const String idColumnName = "id";
  static const String availableColumnName = "available";
  static const String nameColumnName = "name";
  static const String descriptionColumnName = "description";
  static const String pictureColumnName = "picture";
  static const String priceColumnName = "price";

  ProductModel({
    this.id,
    required this.available,
    required this.name,
    required this.description,
    this.picture,
    required this.price,
  });

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json[idColumnName],
        available: json[availableColumnName],
        name: json[nameColumnName],
        description: json[descriptionColumnName],
        picture: json[pictureColumnName],
        price: json[priceColumnName]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        idColumnName: available,
        availableColumnName: available,
        nameColumnName: name,
        descriptionColumnName: description,
        pictureColumnName: picture,
        priceColumnName: price,
      };

  String toJson() => json.encode(toMap());
}
