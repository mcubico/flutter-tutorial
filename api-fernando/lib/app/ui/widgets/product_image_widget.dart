import 'dart:io';

import 'package:apifernando/app/domain/helpers/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String? imagePath;

  const ProductImageWidget({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Container(
        decoration: _buildBoxDecoration,
        width: double.infinity,
        height: 450,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          child: _setImage(imagePath),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      );

  Widget _setImage(String? path) {
    if (path == null || path.isEmpty) return _getNoImage();

    if (path.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage(loadingImagePath),
        image: NetworkImage(imagePath!),
        imageErrorBuilder: (context, error, stackTrace) => _getNoImage(),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }

  Image _getNoImage() {
    return Image.asset(
      noImagePath,
      fit: BoxFit.cover,
    );
  }
}
