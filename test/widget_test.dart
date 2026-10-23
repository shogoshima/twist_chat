import 'package:flutter_test/flutter_test.dart';
import 'package:twist_chat/providers/api_client.dart';

void main() {
  test('uses the production API routes', () {
    expect(baseUrl, 'https://shogoshima.duckdns.org');
    expect(ApiRoutes.login, '/login');
    expect(ApiRoutes.fcm, '/users/fcm');
  });
}
