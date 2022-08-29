import 'package:flutter/material.dart';

import 'package:components/widgets/widgets.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cards'),
          centerTitle: true,
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: const [
              CustomCardWidget(),
              SizedBox(height: 20),
              CardImageWidget(
                imagePath:
                    'https://mymodernmet.com/wp/wp-content/uploads/2022/02/international-landscape-photographer-awards-20.jpeg',
                description: 'Atardecer',
              ),
              SizedBox(height: 20),
              CardImageWidget(
                imagePath:
                    'https://www.saludineroyamor.mx/wp-content/uploads/2019/01/nature10.jpg',
                description: 'Amanecer',
              ),
              SizedBox(height: 20),
              CardImageWidget(
                imagePath:
                    'https://eco-business.imgix.net/uploads/ebmedia/fileuploads/shutterstock_158925020.jpg?fit=crop&h=960&ixlib=django-1.2.0&w=1440',
                description: 'Medio día',
              ),
              SizedBox(height: 20),
              CardImageWidget(
                imagePath:
                    'https://backlightblog.com/images/2021/04/landscape-photography-header.jpg',
              )
            ]));
  }
}
