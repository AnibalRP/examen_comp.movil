import 'package:flutter/material.dart';
import 'package:examen_1/services/product_service.dart';
import 'package:examen_1/providers/product_form_provider.dart';
import 'package:examen_1/widgets/product_image.dart';
import 'package:examen_1/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.SelectProduct!),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;

  const _ProductScreenBody({required this.productService});

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImage(url: product.productImage),
            _ProductForm(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'delete',
            child: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              if (!productForm.isValidForm()) return;
              productService.deleteProduct(product, context);
            },
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'save',
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              if (!productForm.isValidForm()) return;
              productService.editOrCreateProduct(product);
            },
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: productForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.productImage,
              decoration: InputDecortions.authInputDecoration(
                hinText: 'URL de la imagen',
                labelText: 'Imagen',
              ),
              onChanged: (value) => product.productImage = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La URL es obligatoria';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.productName,
              decoration: InputDecortions.authInputDecoration(
                hinText: 'Nombre del producto',
                labelText: 'Nombre',
              ),
              onChanged: (value) => product.productName = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.productPrice.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecortions.authInputDecoration(
                hinText: 'Precio',
                labelText: 'Precio',
              ),
              onChanged: (value) {
                if (int.tryParse(value) == null) {
                  product.productPrice = 0;
                } else {
                  product.productPrice = int.parse(value);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
