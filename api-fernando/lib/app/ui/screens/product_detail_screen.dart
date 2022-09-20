import 'package:apifernando/app/data/services/services.dart';
import 'package:apifernando/app/domain/helpers/constants/constants.dart';
import 'package:apifernando/app/domain/models/models.dart';
import 'package:apifernando/app/domain/providers/providers.dart';
import 'package:apifernando/app/ui/helpers/helpers.dart';
import 'package:apifernando/app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (context) =>
          ProductDetailFormProvider(product: productService.selectedProduct!),
      child: _ProductDetailScreenBody(productService: productService),
    );
  }
}

class _ProductDetailScreenBody extends StatelessWidget {
  const _ProductDetailScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImageWidget(
                    imagePath: productService.selectedProduct?.picture,
                  ),
                  Positioned(top: 20, left: 20, child: _BackButton()),
                  Positioned(top: 20, right: 40, child: _CameraButton()),
                ],
              ),
              _ProductDetailFormContainer(),
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

class _ProductDetailFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration,
        child: _ProductDetailForm(),
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

class _ProductDetailForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productDetailForm = Provider.of<ProductDetailFormProvider>(context);
    final ProductModel product = productDetailForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // Product name
            TextFormField(
              initialValue: product.name,
              onChanged: (value) => product.name = value,
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
              initialValue: '${product.price}',
              onChanged: (value) {
                double? price = double.tryParse(value);
                product.price = price ?? 0;
              },
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorationHelper.authInputDecoration(
                hintText: '\$0.00',
                labelText: 'Price',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(onlyDecimalsRegexp)),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }

                return null;
              },
            ),
            const SizedBox(height: 30),

            SwitchListTile.adaptive(
              value: product.available,
              title: const Text('Available'),
              activeColor: Colors.indigo,
              onChanged: (value) => product.available = value,
            ),
            const SizedBox(height: 30),

            // Submit
          ],
        ),
      ),
    );
  }
}