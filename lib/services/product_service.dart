import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/productos.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> products = [];
  Listado? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }

  loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/product_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    print('>>> Antes de la petición GET a la API');
    final response = await http.get(url, headers: {'authorization': basicAuth});
    print('>>> Después de la petición GET, statusCode: ${response.statusCode}');
    print('>>> Respuesta recibida: ${response.body}');

    try {
      final productsMap = Product.fromJson(response.body);
      products = productsMap.listado;
    } catch (e) {
      print('>>> ERROR al parsear productos: $e');
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = false;
    notifyListeners();
  }

  editOrCreateProduct(Listado product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }
    isEditCreate = false;
    notifyListeners();
  }

  updateProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
      body: product.toMap(),
      headers: {
        'authorization': basicAuth,
      },
    );
    final decodeResp = response.body;
    print(decodeResp);

    final index = products.indexWhere((e) => e.productId == product.productId);
    products[index] = product;
  }

  createProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url,
      body: {
        "product_name": product.productName,
        "product_price": product.productPrice.toString(),
        "product_image": product.productImage,
      },
      headers: {
        'authorization': basicAuth,
      },
    );
    products.add(product);
  }

  deleteProduct(Listado product, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url,
      body: {
        "product_id": product.productId.toString(),
      },
      headers: {
        'authorization': basicAuth,
      },
    );
    products.clear();
    loadProducts();
    Navigator.of(context).pushNamed('list');
  }
}
