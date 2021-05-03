import 'dart:convert';

import 'package:casa_mexicana/api/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<void> get(String host, String path, Map<String, String> headers,
      Map<String, dynamic> params, Function(Response) callback) async {
    http.Response r =
        await http.get(Uri.https(host, path, params), headers: headers);
    if (callback != null) callback(Response.fromJson(json.decode(r.body)));
  }

  static Future<void> post(String host, String path,
      {Map<String, String> headers,
      Object requestBody,
      Function(Response) callback}) async {
    http.Response r = await http.post(Uri.https(host, path),
        body: requestBody, headers: headers);
    if (callback != null) callback(Response.fromJson(json.decode(r.body)));
  }
}
