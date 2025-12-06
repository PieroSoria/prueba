import 'package:prueba/core/resources/data_state.dart';

enum ApiMethod { get, post, put, delete }

abstract class ApiClientRepository {
  Future<DataState> requestApiData(
    String uri, {
    required ApiMethod method,
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  void updateHeader({String? token});
}
