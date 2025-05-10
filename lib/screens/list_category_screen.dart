import 'package:flutter/material.dart';
import 'package:examen_1/models/categorias.dart';
import 'package:examen_1/services/category_service.dart';
import 'package:provider/provider.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    if (categoryService.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (context, index) {
          final category = categoryService.categories[index];
          return ListTile(
            title: Text(category.categoryName),
            subtitle: Text(category.categoryState),
            onTap: () {
              categoryService.selectedCategory = category.copy();
              Navigator.pushNamed(context, 'edit_category');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.selectedCategory = CategoriaItem(
            categoryId: 0,
            categoryName: '',
            categoryState: 'Activa',
          );
          Navigator.pushNamed(context, 'edit_category');
        },
      ),
    );
  }
}
