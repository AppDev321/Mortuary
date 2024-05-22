import 'package:dio/dio.dart';
import 'package:mortuary/core/services/network_service.dart';
import 'package:mortuary/features/navigationbar/data/data_source/splash_data_source.dart';
import 'package:mortuary/features/navigationbar/domain/entities/splash_model.dart';
import 'package:mortuary/features/navigationbar/domain/repo/splash_repo.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/utils/utils.dart';

class SplashRepoImpl implements SplashRepo {
  final SplashDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const SplashRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<AppConfig> getSplashApi(String token) async {
    await checkNetwork(networkInfo);
    try {
      return await remoteDataSource.getSplashApi(token);
    } on GeneralError catch (error) {
      return Future.error(error);
    } catch (exception, stackTrace) {
      return Future.error(GeneralError(
          message: exception is DioError
              ? exception.message
              : exception is GeneralError
                  ? exception.message
                  : exception.toString(),
          stackTrace: stackTrace.toString()));
    }
  }
}
