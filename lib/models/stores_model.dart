class StoreModel {
  final int id;
  final String name;
  final String slug;
  final String notes;
  final String status;
  final String imageUrl;

  StoreModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.notes,
    required this.status,
    required this.imageUrl,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      notes: json['notes'],
      status: json['status'],
      imageUrl: json['image_url'],
    );
  }
}
