import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mortuary/core/constants/app_urls.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/network/dio_client.dart';
import 'package:mortuary/core/utils/utils.dart';

import 'package:mortuary/features/navigationbar/domain/entities/splash_model.dart';
import 'package:mortuary/features/navigationbar/urls.dart';

abstract class SplashDataSource {
  Future<AppConfig> getSplashApi(String token);
}

class SplashDataSourceImpl implements SplashDataSource {
  final DioClient _dio;

  SplashDataSourceImpl(this._dio);

  @override
  Future<AppConfig> getSplashApi(String token) async {
    final response = await _dio.get('${AppUrls.testUrl}$splashApi');


    Map<String, dynamic> decodedJson = response.data;

    customLog(
        url: '${AppUrls.testUrl}$splashApi', response: decodedJson['data']);
    if (response.statusCode != 200) {
      return Future.error(
        GeneralError(
            title: 'Get App Config Details',
            message: 'An error occurred while fetching the data.'),
      );
    }
    // if (!decodedJson['status']) {
    //   return Future.error(GeneralError(
    //       title: 'Fetching Next to Kin', message: decodedJson['message']));
    // }
    return AppConfig.fromJson(decodedJson['data']);
  }
}
