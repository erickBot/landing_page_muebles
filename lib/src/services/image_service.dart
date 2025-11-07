import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laning_page/src/api/backend.dart';
import 'package:laning_page/src/models/image_slider.dart';
import 'package:laning_page/src/models/response_api.dart';

class ImageService {
  final String _url = Backend.apiDev;
  final String _api = '/api/images';

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Future<List<ImageSlider>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.get(url, headers: headers);

      final decodeData = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(decodeData);

      ImageSlider image = ImageSlider.fromJsonList(responseApi.data);

      return image.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
