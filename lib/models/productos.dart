import 'dart:convert';

class Product {
  Product({required this.listado});
  List<Listado> listado;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      listado: List<Listado>.from(json["Listado"].map((x) => Listado.fromMap(x))),
  );
}

class Listado {
  Listado({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState,
  });

  int productId;
  String productName;
  int productPrice;
  String productImage;
  String productState;

  factory Listado.fromMap(Map<String, dynamic> json) {
  try {
    return Listado(
      productId: json["product_id"] ?? 0,
      productName: json["product_name"] ?? '',
      productPrice: json["product_price"] ?? 0,
      productImage: json["product_image"] ?? '',
      productState: json["product_state"] ?? '',
    );
  } catch (e) {
    print('>>> ERROR al crear Listado desde JSON: $e');
    return Listado(
      productId: 0,
      productName: 'ERROR',
      productPrice: 0,
      productImage: '',
      productState: 'Error',
    );
  }
}


  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "product_state": productState,
  };

  Listado copy() => Listado(
    productId: productId,
    productName: productName,
    productPrice: productPrice,
    productImage: productImage,
    productState: productState,
  );

  Map<String, dynamic> toMap() => {
  "product_id": productId.toString(),
  "product_name": productName,
  "product_price": productPrice.toString(),
  "product_image": productImage,
  "product_state": productState,
};

}
