import 'package:apifernando/app/domain/helpers/constants/constants.dart';
import 'package:apifernando/app/domain/models/models.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        width: double.infinity,
        height: 400,
        decoration: _createCardShape(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(url: product.picture),
            _ProductDetail(
              title: product.name,
              description: product.description,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                price: product.price,
              ),
            ),
            if (!product.available)
              const Positioned(top: 0, left: 0, child: _NotAvailable()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 7),
          ),
        ],
      );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage({this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: const AssetImage(loadingImagePath),
          image: NetworkImage(url ?? noImagePath),
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
            noImagePath,
            fit: BoxFit.cover,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  final String title;
  final String description;

  const _ProductDetail({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: _buildBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: _buildBoxDecoration,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$price',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: _buildBoxDecoration,
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => BoxDecoration(
        color: Colors.yellow.shade800,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      );
}
