// To parse this JSON data, do
//
//     final imageSlider = imageSliderFromJson(jsonString);

import 'dart:convert';

ImageSlider imageSliderFromJson(String str) =>
    ImageSlider.fromJson(json.decode(str));

String imageSliderToJson(ImageSlider data) => json.encode(data.toJson());

class ImageSlider {
  String? id;
  String? image;
  List<ImageSlider> toList = [];

  ImageSlider({required this.id, required this.image});

  factory ImageSlider.fromJson(Map<String, dynamic> json) =>
      ImageSlider(id: json["_id"], image: json["image"]);

  ImageSlider.fromJsonList(List<dynamic> jsonList) {
    for (var element in jsonList) {
      ImageSlider list = ImageSlider.fromJson(element);
      toList.add(list);
    }
  }

  Map<String, dynamic> toJson() => {"_id": id, "image": image};
}
