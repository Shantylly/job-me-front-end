import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/exceptions.dart';

class API {
  static const String host =
      String.fromEnvironment('HOST', defaultValue: 'http://localhost:4000/');

  static _throwError(int status) {
    switch (status) {
      case 400:
        throw BadRequestException();
      case 401:
        throw AuthorizationException();
      case 403:
        throw PermissionException();
      default:
        throw DefaultException();
    }
  }

  static Future<dynamic> get(String url) async {
    var response = await http.get(Uri.parse(host + url),
        headers: {'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<dynamic> delete(String url) async {
    var response = await http.delete(Uri.parse(host + url),
        headers: {'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<dynamic> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    var response = await http.post(
      Uri.parse(host + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<dynamic> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    var response = await http.put(
      Uri.parse(host + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }
}
