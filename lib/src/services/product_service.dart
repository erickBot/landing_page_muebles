import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laning_page/src/api/backend.dart';
import 'package:laning_page/src/models/product.dart';
import 'package:laning_page/src/models/response_api.dart';

class ProductService {
  final String _url = Backend.apiProd;
  final String _api = '/api/productos';

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Future<List<Product>> getAll() async {
    try {
      Uri url = Uri.https(_url, '$_api/getAll');

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.get(url, headers: headers);

      final decodeData = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(decodeData);

      Product product = Product.fromJsonList(responseApi.data);

      return product.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Product>> getByIdMueble(String idMueble) async {
    try {
      Uri url = Uri.https(_url, '$_api/getByIdMueble/$idMueble');

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.get(url, headers: headers);

      final decodeData = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(decodeData);

      Product product = Product.fromJsonList(responseApi.data);

      return product.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
