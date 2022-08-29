import 'package:flutter/material.dart';

class CardImageWidget extends StatelessWidget {
  final String imagePath;
  final String? description;

  const CardImageWidget({super.key, required this.imagePath, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          FadeInImage(
            image: NetworkImage(imagePath),
            placeholder: const AssetImage('assets/images/jar-loading.gif'),
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),
          if (description != null)
            Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Text(description ?? '---'),
            )
        ],
      ),
    );
  }
}
