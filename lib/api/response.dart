// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.error,
    this.payload,
  });

  bool error;
  Payload payload;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    error: json["error"],
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "payload": payload.toJson(),
  };
}

class Payload {
  Payload({
    this.message,
  });

  String message;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
