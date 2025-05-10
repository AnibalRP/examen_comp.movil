import 'package:flutter/material.dart';
import 'package:examen_1/models/productos.dart';
import 'package:examen_1/screens/loading_screen.dart';
import 'package:examen_1/services/product_service.dart';
import 'package:examen_1/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:examen_1/providers/cart_provider.dart';


class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, __) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black,),
                  onPressed: () {
                    // acción del carrito
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemExtent: 280,
        cacheExtent: 500,
        itemCount: productService.products.length,
        itemBuilder: (context, index) {
          final product = productService.products[index];
          return GestureDetector(
            onTap: () {
              productService.SelectProduct = product.copy();
              Navigator.pushNamed(context, 'edit');
            },
            child: ProductCard(product: product),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage: 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png',
            productState: '',
          );
          Navigator.pushNamed(context, 'edit');
        },
      ),
    );
  }
}
