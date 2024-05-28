import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as GETX;
import 'package:mortuary/core/network/dio_client.dart';
import 'package:mortuary/core/network/dio_exception.dart';

import '../../features/authentication/presentation/get/auth_controller.dart';
import '../error/errors.dart';
import '../services/network_service.dart';
import '../utils/utils.dart';

enum RequestMethod { POST, DELETE, PUT, GET }

class ApiResponse {
  final CustomError? error;
  final bool status;
  final String message;
  Map<String, dynamic>? data;
  ApiResponse(this.data, this.error, this.status, this.message);
}

class ApiManager {
  final DioClient _dio;
  final FlutterSecureStorage secureStorage;
  final NetworkInfo networkInfo;

  ApiManager(this._dio, this.secureStorage, this.networkInfo);


  String? get token {
    try {
      return GETX.Get.find<AuthController>().session?.sessionId;
    } catch (e) {
      return null;
    }
  }


  Future<ApiResponse> callNetworkApiRequest<T>({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? data,
    dynamic files,
  }) async {
    try {
      Response response;
      var options = Options(
        contentType: "application/json",
        validateStatus: (status) {
          return true;
        },
        headers: token != null ? {
          "Authorization": "Bearer $token",
        } : {},
      );
      switch (method) {
        case RequestMethod.GET:
          response = await _dio.get(url, options: options);
          break;
        case RequestMethod.POST:
          if (files != null) {
            print(files.fields);
            response = await _dio.post(url, options: options, data: files);
          }else {
            response = await _dio.post(url,
                options: options, data: FormData.fromMap(data ?? {}));
          }
          break;

        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      final Map<String, dynamic> decodedJson = response.data;

      if (response.statusCode == 200) {
        return ApiResponse(decodedJson, null, true, decodedJson['message']);
      } else if (response.data != null) {

        var error = decodedJson['errors'] as String;
        error.replaceAll("###", "\n");
        return ApiResponse(
            null,
            GeneralError(message: error,title: decodedJson['message']),
            false,
            "Failed to get data");
      } else {

        throw DioExceptions.fromDioError(DioError(
          response: response,
          requestOptions: RequestOptions(path: url),
        ));
      }
    } catch (e) {
      return ApiResponse(null, GeneralError(message: e.toString()), false,
          "Failed to get data");
    }
  }


  Future<T> handleRequest<T>(Future<T> Function() request) async {
    await checkNetwork(networkInfo);

    try {
      return await request();
    } on GeneralError catch (error) {
      return Future.error(error);
    } catch (exception, stackTrace) {
      return Future.error(GeneralError(
        message: exception is DioError
            ? exception.message
            : exception is GeneralError
            ? exception.message
            : exception.toString(),
        stackTrace: stackTrace.toString(),
      ));
    }
  }

  Future<T> makeApiRequest<T>({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await callNetworkApiRequest<ApiResponse>(
        url: url, method: method, data: data);

    if (response.error != null) {
      return Future.error(response.error!);
    } else {
      return fromJson(response.data!);
    }
  }

  Future<T> makeFileUploadRequest<T>({
    required String url,
    required RequestMethod method,
    dynamic data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await callNetworkApiRequest<ApiResponse>(
        url: url, method: method, files: data,);

    if (response.error != null) {
      return Future.error(response.error!);
    } else {
      return fromJson(response.data!);
    }
  }


}
