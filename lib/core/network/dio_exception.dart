import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {

    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        print("error response");
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:

        if(dioError.response != null)
          {
            message = _handleError(
              dioError.response?.statusCode,
              dioError.response?.data,
            );
          }
       else if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
        }
       else {
          message = "Unexpected error occurred";
        }
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['data']['errors'][0];
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Server is currently down. Please try again later.';
      case 422:
        return error['data'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}