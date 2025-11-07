import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laning_page/src/api/backend.dart';
import 'package:laning_page/src/models/response_api.dart';
import 'package:laning_page/src/models/util.dart';

class UtilService {
  final String _url = Backend.apiProd;
  final String _api = '/api/util';

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Future<Util?> getAll() async {
    try {
      Uri url = Uri.https(_url, '$_api/getAll');

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.get(url, headers: headers);

      final decodeData = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(decodeData);

      Util util = Util.fromJson(responseApi.data);

      return util;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
