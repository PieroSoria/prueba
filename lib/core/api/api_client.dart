import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:prueba/core/api/api_client_repository.dart';

import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/helpers/logger.dart';

class ApiClient implements ApiClientRepository {
  final String baseUrl;
  Dio dio;
  static const String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 40;

  ApiClient({required this.baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
            Headers.acceptHeader: Headers.jsonContentType,
          },
        ),
      );

  @override
  void updateHeader({String? token}) async {
    dio.options = dio.options.copyWith(
      headers: {
        ...dio.options.headers,
        'Authorization': token != null ? 'Bearer $token' : '',
      },
    );
  }

  @override
  Future<DataState> requestApiData(
    String uri, {
    required ApiMethod method,
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.request(
        uri,
        data: jsonEncode(body),
        queryParameters: query,
        options: Options(
          method: method.name.toUpperCase(),
          headers: headers,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      return handleResponse(
        response,
        uri,
        body: body,
        method: method,
        headers: headers,
        queryParameters: query,
      );
    } on DioException catch (e) {
      return handleResponse(
        e.response,
        uri,
        body: body,
        method: method,
        headers: headers,
        queryParameters: query,
      );
    }
  }

  Future<DataState> handleResponse(
    Response? response,
    String uri, {
    dynamic body,
    required ApiMethod method,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (kDebugMode) {
        LoggerHelper.log('======> API URL: ${response?.realUri}');
        LoggerHelper.log(
          '====> API STATUSCODE: [${response?.statusCode}] $uri',
        );
        LoggerHelper.log('======> API METHOD: $method');
        LoggerHelper.log('==> API BODY: $body');
        LoggerHelper.log('==> API RESPONSE: ${response?.data}');
        LoggerHelper.log(
          "==> API TOKEN ${response?.requestOptions.headers['Authorization']}",
        );
      }
      if (![200, 201, 202].contains(response?.statusCode ?? 500)) {
        return DataFailed(
          errorMessage: ErrorMessage(
            title: "Error",
            message: "No se pudo Obtener los Datos",
          ),
        );
      }

      return DataSuccess(
        ResultSuccess(
          title: "Exito",
          message: "Se Obtuvo los Datos Requeridos",
          data: response?.data,
        ),
      );
    } catch (e) {
      return DataFailed(
        errorMessage: ErrorMessage(
          title: 'Error',
          message: 'Error inesperado del servidor',
        ),
      );
    }
  }
}
