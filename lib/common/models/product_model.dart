// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"] == null
            ? json["category"]
            : Category.fromJson(json["category"]),
        images: json["images"] == null
            ? json["images"]
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category == null ? category : category!.toJson(),
        "images":
            images == null ? images : List<dynamic>.from(images!.map((x) => x)),
      };
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
