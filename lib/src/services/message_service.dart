import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laning_page/src/api/backend.dart';
import 'package:laning_page/src/models/response_api.dart';

class MessageService {
  final String _url = Backend.apiProd;
  final String _api = '/api/consultas';

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi?> sendMessage(
    String name,
    String email,
    String message,
  ) async {
    try {
      Uri url = Uri.https(_url, '$_api/enviar');

      Map<String, String> headers = {'Content-type': 'application/json'};

      String bodyParam = json.encode({
        'name': name,
        'email': email,
        'message': message,
      });

      final res = await http.post(url, headers: headers, body: bodyParam);

      final decodeData = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(decodeData);

      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
