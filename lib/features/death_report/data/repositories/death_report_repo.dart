import 'package:geolocator/geolocator.dart';
import 'package:mortuary/core/network/empty_success_response.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/report_a_death_response.dart';
import '../data_source/death_report_remote_source.dart';

abstract class DeathReportRepo {
  Future<ReportDeathResponse> volunteerDeathReport(
  {required int deathBodyCount,required int locationId,required double lat,required double lng,required String address});
}

class DeathReportRepoImpl extends DeathReportRepo {
  final DeathReportRemoteSource remoteDataSource;
  final ApiManager apiManager;

  DeathReportRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });

  @override
  Future<ReportDeathResponse> volunteerDeathReport(
  {required int deathBodyCount,required int locationId,required double lat,required double lng,required String address}) async {
    return apiManager.handleRequest(() async {
      final session = await remoteDataSource.volunteerDeathReport(
          deathBodyCount, locationId, lat,lng,address);
      return session;
    });
  }
}
