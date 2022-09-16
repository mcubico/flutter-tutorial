import 'package:apifernando/app/ui/helpers/helpers.dart';
import 'package:apifernando/app/ui/widgets/product_image_widget.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const ProductImageWidget(),
                  Positioned(top: 20, left: 20, child: _BackButton()),
                  Positioned(top: 20, right: 40, child: _CameraButton()),
                ],
              ),
              _ProductFormContainer(),
              const SizedBox(height: 100),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        size: 40,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.camera_alt_outlined,
        size: 40,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _ProductFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration,
        child: _ProductForm(),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ]);
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // Product name
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorationHelper.authInputDecoration(
                hintText: 'Product name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                return null;
              },
            ),
            const SizedBox(height: 30),

            // Price
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecorationHelper.authInputDecoration(
                hintText: '\$0.00',
                labelText: 'Price',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }

                return null;
              },
            ),
            const SizedBox(height: 30),

            SwitchListTile.adaptive(
              value: true,
              title: const Text('Available'),
              activeColor: Colors.indigo,
              onChanged: (value) {},
            ),
            const SizedBox(height: 30),

            // Submit
          ],
        ),
      ),
    );
  }
}
