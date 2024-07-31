import 'package:dio/dio.dart';

class Errors {
  static String getErrorMessage({exception}) {
    String error = exception.toString();
    if (exception is NetworkException) {
      error = exception.message;
    } else if (exception is SessionExpiredException) {
      error = exception.message;
    } else if (exception is GeneralExceptions) {
      error = exception.message;
    } else if (exception is ServerException) {
      error = exception.message ?? "server exception";
    }
    return error;
  }
}

class ServerException implements Exception {
  String? message;

  ServerException({required this.message});

  ServerException.fromDioError(DioException dioError) {
    print("this is catch of dio error");
    print("this is error message : ${dioError.message.toString()}");
    print("this is error type : ${dioError.type}");
    print("this is error response : ${dioError.response}");

    if (dioError.type == DioExceptionType.cancel) {
      message = "Request to API server was cancelled";
    } else if (dioError.type == DioExceptionType.connectionTimeout) {
      message = "Connection timeout with API server";
    } else if (dioError.type == DioExceptionType.sendTimeout) {
      message = "Send timeout in connection with API server";
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      message = "Receive timeout in connection with API server";
    } else if (dioError.type == DioExceptionType.badResponse) {
      message = dioError.response!.data;
    }
    else {
      message = "dio error";
    }
  }

  @override
  String toString() => message!;
}

class NetworkException implements Exception {
  final String message = "You are not connected to internet أنت غير متصل بالإنترنت";
  NetworkException();
}

class SessionExpiredException implements Exception {
  String message = "Your session has expired لقد انتهت صلاحية الجلسة";
  SessionExpiredException(this.message);
}

class GeneralExceptions implements Exception {
  String message;
  GeneralExceptions({required this.message});
}
