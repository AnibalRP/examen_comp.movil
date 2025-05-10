import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: _createDecoration(),
        width: double.infinity,
        height: 400,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),topRight: Radius.circular(45),
          ),

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
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ],
      );
}
