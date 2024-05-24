import 'package:geolocator/geolocator.dart';
import 'package:mortuary/core/network/empty_success_response.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/network/api_manager.dart';
import '../data_source/death_report_remote_source.dart';

class DeathReportRepo {
  final DeathReportRemoteSource remoteDataSource;
  final ApiManager apiManager;

  DeathReportRepo({
    required this.remoteDataSource,
    required this.apiManager,
  });

  Future<EmptyResponse> volunteerDeathReport(
      {required int deathBodyCount,
      required int locationId,
      required Position latLng}) async {
    return apiManager.handleRequest(() async {
      final session = await remoteDataSource.volunteerDeathReport(
          deathBodyCount, locationId, latLng);
      return session;
    });
  }
}
