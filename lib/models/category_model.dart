class CategoryModel {
  final int id;
  final int? parentId;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: int.parse(json["id"]),
      parentId: int.parse(json["parentId"]),
      name: json["name"],
      slug: json["slug"],
      status: json["status"],
      notes: json["notes"],
      imageUrl: json["imageUrl"],

    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "parentId": this.parentId,
      "name": this.name,
      "slug": this.slug,
      "status": this.status,
      "notes": this.notes,
      "imageUrl": this.imageUrl,
    };
  }

  final String name;
  final String slug;
  final String status;
  final String notes;
  final String imageUrl;


  CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    required this.slug,
    required this.status,
    required this.notes,
    required this.imageUrl,

  });
}

