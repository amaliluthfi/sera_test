// To parse this JSON data, do
//
//     final Categories = CategoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(List str) =>
    List<Categories>.from(str.map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  int? id;
  String? name;
  String? image;
  bool selected;

  Categories({this.id, this.name, this.image, this.selected = false});

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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
