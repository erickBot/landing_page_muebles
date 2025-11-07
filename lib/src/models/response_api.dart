// To parse this JSON data, do
//
//     final responseApi = responseApiFromJson(jsonString);

import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? msg;
  String? error;
  bool? success;
  dynamic data;

  ResponseApi({
    this.msg,
    this.error,
    this.success,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    msg = json["msg"];
    error = json["error"];
    success = json["success"];

    try {
      data = json['data'];
    } catch (e) {
      print('Exception data $e');
    }
  }

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": data,
        "success": success,
      };
}
