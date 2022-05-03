import 'package:http/http.dart';

import 'api_client.dart';

class ApiUlti {
  late final ApiClient client;

  ApiUlti._privateConstructor() {
    client = ApiClient();
  }

  static final ApiUlti instance = ApiUlti._privateConstructor();
}
