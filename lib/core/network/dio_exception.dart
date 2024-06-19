import 'package:dio/dio.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/network/request_interceptor.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    logDebug(dioError.type.toString());
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = ApiMessages.requestCancel;
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = ApiMessages.receiveTimeout;
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = ApiMessages.sendTimeout;
        break;
      case DioErrorType.other:
        if (dioError.response != null) {
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
        } else if (dioError.message.contains("SocketException")) {
          message = ApiMessages.noInternet;
        } else {
          message = ApiMessages.unexpectedError;
        }
        break;
      default:
        message = ApiMessages.somethingWentWrong;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    logDebug(statusCode.toString());
    switch (statusCode) {
      case 400:
        return error['errors'];
      case 401:
        return ApiMessages.unAuthorized;
      case 403:
        return ApiMessages.forbidden;
      case 503:
      case 404:
        return ApiMessages.serverNotAvailable;
      case 422:
        return error['errors'];
      case 500:
        return ApiMessages.internalServerError;
      case 502:
        return ApiMessages.badGateWay;

      default:
        return ApiMessages.somethingWentWrong;
    }
  }

  @override
  String toString() => message;
}
