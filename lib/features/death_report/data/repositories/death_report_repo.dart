import 'package:geolocator/geolocator.dart';
import 'package:mortuary/core/network/empty_success_response.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/network/api_manager.dart';
import '../data_source/death_report_remote_source.dart';

abstract class DeathReportRepo {
  Future<EmptyResponse> volunteerDeathReport(
  {required int deathBodyCount,required int locationId,required Position latLng});
}

class DeathReportRepoImpl extends DeathReportRepo {
  final DeathReportRemoteSource remoteDataSource;
  final ApiManager apiManager;

  DeathReportRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });

  @override
  Future<EmptyResponse> volunteerDeathReport(
  {required int deathBodyCount,required int locationId,required Position latLng}) async {
    return apiManager.handleRequest(() async {
      final session = await remoteDataSource.volunteerDeathReport(
          deathBodyCount, locationId, latLng);
      return session;
    });
  }
}
