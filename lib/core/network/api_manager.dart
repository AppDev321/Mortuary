import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mortuary/core/network/dio_client.dart';
import 'package:mortuary/core/network/dio_exception.dart';

import '../error/errors.dart';

enum RequestMethod { POST, DELETE,PUT,GET }

class ApiResponse{
  final CustomError? error;
  final bool status;
  final String message;
  Map<String, dynamic>? data;
  ApiResponse(this.data, this.error, this.status, this.message);
}

class ApiManager {
  final DioClient _dio;
  final FlutterSecureStorage secureStorage;

  ApiManager(this._dio, this.secureStorage);


  Future<ApiResponse> callNetworkApiRequest<T>({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response;

      var options = Options(
        contentType: "application/json",
        validateStatus: (status) {
          return true;
        },
        /*headers: {
          "Authorization": "Bearer ${token}",
        },*/
      );
      switch (method) {
        case RequestMethod.GET:
          response = await _dio.get(url, options: options);
          break;
        case RequestMethod.POST:
          response = await _dio.post(url,
              options: options, data: FormData.fromMap(data ?? {}));
          break;

        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      final Map<String, dynamic> decodedJson = response.data;
      if (response.statusCode == 200) {
        return ApiResponse(decodedJson, null,true,decodedJson['message']);
      } else {
        throw DioExceptions.fromDioError(DioError(
          response: response,
          requestOptions: RequestOptions(path: url),
        ));
      }
    } catch (e) {
      return ApiResponse(null, GeneralError(message: e.toString()),false,"Failed to get data");
    }
  }
}
