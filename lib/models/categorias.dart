import 'dart:convert';

class Categoria {
  Categoria({required this.listado});
  List<CategoriaItem> listado;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
    listado: List<CategoriaItem>.from(json["Listado"].map((x) => CategoriaItem.fromMap(x))),
  );
}

class CategoriaItem {
  CategoriaItem({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory CategoriaItem.fromMap(Map<String, dynamic> json) => CategoriaItem(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryState: json["category_state"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_state": categoryState,
  };

  CategoriaItem copy() => CategoriaItem(
    categoryId: categoryId,
    categoryName: categoryName,
    categoryState: categoryState,
  );

  Map<String, dynamic> toMap() => {
  "category_id": categoryId.toString(),
  "category_name": categoryName,
  "category_state": categoryState,
};

}
