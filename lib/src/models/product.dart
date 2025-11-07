// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? idMueble;
  String? name;
  String? description;
  List<String>? images;
  double? price;
  String? largo;
  String? ancho;
  String? profundidad;
  String? material;
  String? espesor;
  List<Product> toList = [];

  Product({
    this.id,
    this.idMueble,
    this.name,
    this.description,
    this.images,
    this.price,
    this.largo,
    this.ancho,
    this.profundidad,
    this.material,
    this.espesor,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    idMueble: json["id_mueble"],
    name: json["name"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    price: json["price"]?.toDouble(),
    largo: json["largo"],
    ancho: json["ancho"],
    profundidad: json["profundidad"],
    material: json["material"],
    espesor: json["espesor"],
  );

  Product.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      Product list = Product.fromJson(element);
      toList.add(list);
    }
  }
  Map<String, dynamic> toJson() => {
    "_id": id,
    "id_mueble": idMueble,
    "name": name,
    "description": description,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "price": price,
    "largo": largo,
    "ancho": ancho,
    "profundidad": profundidad,
    "material": material,
    "espesor": espesor,
  };
}
