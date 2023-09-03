class CategoryModel {
  final int id;
  final int? parentId;
  final String name;
  final String slug;
  final String status;
  final String notes;
  final String imageUrl;
  final CategoryParent? parent;

  CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    required this.slug,
    required this.status,
    required this.notes,
    required this.imageUrl,
    this.parent,
  });
}

class CategoryParent {
  final String name;
  final String imageUrl;

  CategoryParent({
    required this.name,
    required this.imageUrl,
  });
}
