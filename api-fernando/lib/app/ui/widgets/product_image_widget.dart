import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

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
          child: FadeInImage(
            placeholder: const AssetImage('assets/images/jar-loading.gif'),
            image: const NetworkImage(
                'https://via.placeholder.com/400x300/f6f6f6'),
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/no-image.png',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => BoxDecoration(
        color: Colors.red,
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
}
