import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

// Necessary for code-generation to work
part 'api_client.g.dart';

// const String baseUrl = 'https://shogoshima.duckdns.org';
const String baseUrl = 'http://192.168.15.6:8080';

class ApiRoutes {
  static String chats = '/chats';
  static String summaries = '/chats/summaries';
  static String textFilters = '/chats/textfilters';
  static String dm = '/chats/dm';
  static String group = '/chats/group';

  static String login = '/login';

  static String users = '/users';
  static String me = '/users/me';
  static String fcm = '/users/fcm';
}

@Riverpod(keepAlive: true)
class ApiClient extends _$ApiClient {
  @override
  ApiClient build() {
    return this;
  }

  Future<dynamic> get(String endpoint, [Map<String, dynamic>? query]) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  Future<void> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
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
