import 'package:flutter/material.dart';
import 'package:examen_1/models/productos.dart';

class ProductCard extends StatelessWidget {
  final Listado product;
  final Widget? trailling;

  const ProductCard({super.key, required this.product, this.trailling});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardDecorations(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackGroundImage(url: product.productImage),
            _ProductDetails(product: product),
            Positioned(top: 0, right: 0, child: _PriceTag(product: product)),
            if (trailling != null)
              Positioned(bottom: 10, right: 10, child: trailling!),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecorations() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
        ],
      );
}

class _PriceTag extends StatelessWidget {
  final Listado product;

  const _PriceTag({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 209, 163, 237),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$${product.productPrice}',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Listado product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 80,
        decoration: _boxDecorations(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Text(
              'SKU',
              style: TextStyle(fontSize: 15, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecorations() => const BoxDecoration(
        color: Color.fromARGB(255, 177, 128, 236),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}

class _BackGroundImage extends StatelessWidget {
  final String? url;

  const _BackGroundImage({this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null || url!.isEmpty
            ? const Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : Image.network(
                url!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                errorBuilder: (context, error, stackTrace) {
                  return const Image(
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }
}
