import 'package:flutter/material.dart';
import 'package:examen_1/services/category_service.dart';
import 'package:examen_1/providers/category_form_provider.dart';
import 'package:examen_1/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    return ChangeNotifierProvider(
      create: (_) => CategoryFormProvider(categoryService.selectedCategory!),
      child: _CategoryScreenBody(categoryService: categoryService),
    );
  }
}

class _CategoryScreenBody extends StatelessWidget {
  final CategoryService categoryService;

  const _CategoryScreenBody({required this.categoryService});

  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final category = categoryForm.category;

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: categoryForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: category.categoryName,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre de la categoría',
                  labelText: 'Nombre',
                ),
                onChanged: (value) => category.categoryName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: category.categoryState,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Estado (Ej: Activa)',
                  labelText: 'Estado',
                ),
                onChanged: (value) => category.categoryState = value,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'delete_category',
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      if (!categoryForm.isValidForm()) return;
                      categoryService.deleteCategory(category, context);
                    },
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: 'save_category',
                    child: const Icon(Icons.save),
                    onPressed: () {
                      if (!categoryForm.isValidForm()) return;
                      categoryService.editOrCreateCategory(category);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
