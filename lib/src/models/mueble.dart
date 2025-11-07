// To parse this JSON data, do
//
//     final mueble = muebleFromJson(jsonString);

import 'dart:convert';

Mueble muebleFromJson(String str) => Mueble.fromJson(json.decode(str));

String muebleToJson(Mueble data) => json.encode(data.toJson());

class Mueble {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  List<Mueble> toList = [];

  Mueble({this.id, this.name, this.description, this.imageUrl});

  factory Mueble.fromJson(Map<String, dynamic> json) => Mueble(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
  );

  Mueble.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      Mueble list = Mueble.fromJson(element);
      toList.add(list);
    }
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "image_url": imageUrl,
  };
}
