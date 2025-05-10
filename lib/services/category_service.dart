import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categorias.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<CategoriaItem> categories = [];
  CategoriaItem? selectedCategory;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }

  loadCategories() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    try {
      final response = await http.get(url, headers: {'authorization': basicAuth});
      final categoryMap = Categoria.fromJson(response.body);
      categories = categoryMap.listado;
    } catch (e) {
      print('>>> ERROR al parsear categorías: $e');
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = false;
    notifyListeners();
  }

  editOrCreateCategory(CategoriaItem category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoryId == 0) {
      await createCategory(category);
    } else {
      await updateCategory(category);
    }
    isEditCreate = false;
    notifyListeners();
  }

  updateCategory(CategoriaItem category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: category.toMap(), headers: {'authorization': basicAuth});
  }

  createCategory(CategoriaItem category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: {
      "category_name": category.categoryName,
    }, headers: {'authorization': basicAuth});
    categories.add(category);
  }

  deleteCategory(CategoriaItem category, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: {
      "category_id": category.categoryId.toString(),
    }, headers: {'authorization': basicAuth});
    categories.clear();
    loadCategories();
    Navigator.of(context).pushNamed('list_category');
  }
}
