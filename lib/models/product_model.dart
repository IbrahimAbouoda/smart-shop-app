
class Category {
  final int id;
  final String name;
  final String? imageUrl;

  Category(this.id, this.name, this.imageUrl);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['id'],
      json['name'],
      json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
    };
  }
}

class Store {
  final int id;
  final String name;
  final String? imageUrl;

  Store(this.id, this.name, this.imageUrl);

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      json['id'],
      json['name'],
      json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
    };
  }
}

class Tag {
  final int id;
  final String name;

  Tag(this.id, this.name);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['id'],
      json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class ProductModel {
  final int id;
  final int storeId;
  final int categoryId;
  final String name;
  final String slug;
  final double price;
  final double comparePrice;
  final int quantity;
  final String status;
  final String type;
  final String notes;
  final int size;
  final String manufacturerCompany;
  final String productMaterial;
  final int rating;
  final int featured;
  final List<dynamic>? options;
  final String? imageUrl;
  final Category category;
  final Store store;
  final List<Tag> tags;

  ProductModel({
    required this.id,
    required this.storeId,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.price,
    required this.comparePrice,
    required this.quantity,
    required this.status,
    required this.type,
    required this.notes,
    required this.size,
    required this.manufacturerCompany,
    required this.productMaterial,
    required this.rating,
    required this.featured,
    required this.options,
    required this.imageUrl,
    required this.category,
    required this.store,
    required this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      storeId: json["storeId"] != null ? int.parse(json["storeId"]) : 0,
      categoryId: json["categoryId"] ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
     price: json["price"] != null ? (json["price"] is int ? json["price"].toDouble() : json["price"]) : 0.0,

      comparePrice: json["comparePrice"] != null
          ? double.parse(json["comparePrice"])
          : 0.0,
      quantity: json["quantity"] != null ? (json["quantity"] is int ? json["quantity"] : int.parse(json["quantity"])) : 0,

      status: json["status"] ?? "",
      type: json["type"] ?? "",
      notes: json["notes"] ?? "",
size: json["size"] != null ? (json["size"] is int ? json["size"] : int.parse(json["size"])) : 0,
      manufacturerCompany: json["manufacturerCompany"] ?? "",
      productMaterial: json["productMaterial"] ?? "",
rating: json["rating"] ?? 0,
featured: json["featured"] ?? 0,
      options: json["options"] != null
          ? List.of(json["options"])
              .map((i) => i /* handle properly */)
              .toList()
          : [],
      imageUrl: json["imageUrl"] ?? "",
    category: json["category"] != null
    ? Category.fromJson(json["category"] as Map<String, dynamic>)
    : Category(0, "", null),

      store: json["store"] != null ? Store.fromJson(json["store"]) : Store(0,"",null),
      tags: (json['tag'] as List<dynamic>?)
              ?.map((tagJson) => Tag.fromJson(tagJson))
              .toList() ??
          [],
    );
  }

//
}

class ProductList {
  final int currentPage;
  final List<ProductModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Map<String, dynamic>> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ProductList(
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  );

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      json['current_page'] ?? 0,
      (json['data'] as List<dynamic>)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
      json['first_page_url'],
      json['from'],
      json['last_page'],
      json['last_page_url'],
      List<Map<String, dynamic>>.from(json['links']),
      json['next_page_url'],
      json['path'],
      json['per_page'],
      json['prev_page_url'],
      json['to'],
      json['total'],
    );
  }
}
