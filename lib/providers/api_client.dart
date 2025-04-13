import 'dart:convert';
import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Necessary for code-generation to work
part 'api_client.g.dart';

const String baseUrl = 'https://shogoshima.duckdns.org';

class ApiRoutes {
  static String chats = '/chats';
  static String summaries = '/chats/summaries';
  static String textFilters = '/chats/textfilters';

  static String users = '/users';
  static String login = '/auth/login';
  static String me = '/users/me';
}

@Riverpod(keepAlive: true)
class ApiClient extends _$ApiClient {
  late final FlutterSecureStorage _storage;

  @override
  ApiClient build() {
    _storage = const FlutterSecureStorage();
    return this;
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: 'jwtToken', value: token);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: 'jwtToken');
  }

  Future<dynamic> get(String endpoint, [Map<String, dynamic>? query]) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);
    final token = await _storage.read(key: 'jwtToken');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final token = await _storage.read(key: "jwtToken");

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final token = await _storage.read(key: "jwtToken");

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  Future<void> delete(String endpoint, String id) async {
    final uri = Uri.parse('$baseUrl$endpoint/$id');
    final token = await _storage.read(key: "jwtToken");

    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    log("Response: ${response.body}, Status Code: ${response.statusCode}");
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json;
    } else {
      throw Exception('[Error ${response.statusCode}] ${json['error']}');
    }
  }
}
