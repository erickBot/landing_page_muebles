// To parse this JSON data, do
//
//     final util = utilFromJson(jsonString);

import 'dart:convert';

Util utilFromJson(String str) => Util.fromJson(json.decode(str));

String utilToJson(Util data) => json.encode(data.toJson());

class Util {
  String? id;
  String? imageUrl;
  String? email;
  String? whatsapp;
  String? address;

  Util({this.id, this.imageUrl, this.email, this.whatsapp, this.address});

  factory Util.fromJson(Map<String, dynamic> json) => Util(
    id: json["_id"],
    imageUrl: json["image_url"],
    email: json["email"],
    whatsapp: json["whatsapp"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image_url": imageUrl,
    "email": email,
    "whatsapp": whatsapp,
    "address": address,
  };
}
