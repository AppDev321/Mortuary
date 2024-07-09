import 'package:dio/dio.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/network/log_debugger_style.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    logDebug(dioError.type.toString());
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = ApiMessages.requestCancel;
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = ApiMessages.receiveTimeout;
        break;
      case DioExceptionType.sendTimeout:
        message = ApiMessages.sendTimeout;
        break;
      case DioExceptionType.connectionError:
        message = ApiMessages.noInternet;
        break;
      case DioExceptionType.unknown:
        if (dioError.response != null) {
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
        }
        //else if (dioError.message!.contains("SocketException")) {
      //    message = ApiMessages.noInternet;
      //  }
        else {
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
