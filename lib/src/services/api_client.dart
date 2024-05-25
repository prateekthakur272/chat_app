import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

typedef TokenProvider = Future<String?> Function();
typedef ResponseData = Map<String, dynamic>;
typedef Headers = Map<String, String>;

class ApiClient {
  final TokenProvider _tokenProvider;
  final String _baseUrl;
  final http.Client? _client;

  ApiClient({
    required TokenProvider tokenProvider,
    http.Client? client,
  }) : this.withBaseUrl(
            client: client, tokenProvider: tokenProvider, baseUrl: 'http://localhost:8080');

  ApiClient.withBaseUrl({
    required TokenProvider tokenProvider,
    required String baseUrl,
    http.Client? client,
  })  : _tokenProvider = tokenProvider,
        _baseUrl = baseUrl,
        _client = client ?? http.Client();

  Future<ResponseData> handleRequest(
      Future<http.Response> Function(Map<String, String>) request) async {
    try {
      final headers = await getRequestHeaders();
      final response = await request(headers);
      final body = jsonDecode(response.body);

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('${response.statusCode}, error: ${body['message']}');
      }
      return body;
    } on TimeoutException {
      throw Exception('Request timeout. Please try again');
    } catch (err) {
      throw Exception('Unexpected error: $err');
    }
  }

  Future<Headers> getRequestHeaders() async {
    final token = await _tokenProvider();
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<ResponseData> get(String url) async {
    final uri = Uri.parse(url);
    final data = await handleRequest(
        (headers) => _client!.get(uri, headers: headers));
    return data;
  }
}
