import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ApiClient {
  final Map<String, String> _headers = const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Uri _uri(String endpoint) => Uri.parse('${ApiConstants.baseUrl}$endpoint');

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(_uri(endpoint), headers: _headers);
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      _uri(endpoint),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      _uri(endpoint),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(_uri(endpoint), headers: _headers);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    throw Exception(
      body is Map && body['message'] != null
          ? body['message']
          : 'Request gagal: ${response.statusCode}',
    );
  }
}
