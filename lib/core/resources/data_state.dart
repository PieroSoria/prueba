import 'package:dio/dio.dart';

abstract class DataState {
  final ResultSuccess? response;
  final DioException? dioException;
  final ErrorMessage? errorMessage;

  DataState({this.response, this.dioException, this.errorMessage});
}

class DataSuccess extends DataState {
  DataSuccess(ResultSuccess response) : super(response: response);
}

class DataFailed extends DataState {
  DataFailed({super.dioException, super.errorMessage});
}

class ErrorMessage {
  final String? title;
  final String? message;

  ErrorMessage({required this.title, required this.message});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(title: json['status'], message: json['message']);
  }

  Map<String, dynamic> toJson() => {'status': title, 'message': message};
}

class ResultSuccess {
  final String? title;
  final String? message;
  final dynamic data;

  ResultSuccess({this.title, this.message, this.data});

  factory ResultSuccess.fromJson(Map<String, dynamic> json) {
    return ResultSuccess(
      title: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': title,
    'message': message,
    'data': data,
  };
}
