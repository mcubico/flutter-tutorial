import 'package:flutter/material.dart';
import 'package:formularios/app/ui/widgets/widgets.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key});

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
          children: const [_BackgroundImage(), _ProductDetail()],
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
            offset: Offset(0, 5),
          ),
        ],
      );
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: const SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: AssetImage('assets/images/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
