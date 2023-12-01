// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  Category? category;
  @HiveField(5)
  List<String>? images;
  @HiveField(6)
  bool? addedToCart;
  @HiveField(7)
  int quantity;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images,
      this.addedToCart = false,
      this.quantity = 0});

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

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
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
