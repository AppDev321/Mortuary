import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_alert.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/report_a_death_response.dart';
import '../data_source/death_report_remote_source.dart';

abstract class DeathReportRepo {
  Future<ReportDeathResponse> volunteerDeathReport(
      {required int deathBodyCount,
      required int locationId,
      required double lat,
      required double lng,
      required String address});

  Future<int> postQRScanCode(String qrCode);

  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest});

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole);

  Future<List<DeathReportAlert>> checkAnyAlertExits();

  Future<DeathReportAlert> getDeathReportDetailsById(
      {required int deathReportId});

  Future<Map<String,dynamic>> acceptDeathReportAlertByTransport({required int deathReportId});

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
      {required int deathBodyCount,
      required int locationId,
      required double lat,
      required double lng,
      required String address}) async {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.initiateDeathReport(
          deathBodyCount, locationId, lat, lng, address);
    });
  }

  @override
  Future<int> postQRScanCode(String qrCode) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.postQRScanCode(qrCode);
    });
  }

  @override
  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.postDeathReportForm(
          formRequest: formRequest);
    });
  }

  @override
  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.getDeathReportList(userRole);
    });
  }

  @override
  Future<List<DeathReportAlert>> checkAnyAlertExits() {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.checkAnyAlertExits();
    });
  }

  @override
  Future<DeathReportAlert> getDeathReportDetailsById(
      {required int deathReportId}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.getDeathReportDetailsById(
          deathReportId: deathReportId);
    });
  }

  @override
  Future<Map<String, dynamic>> acceptDeathReportAlertByTransport({required int deathReportId}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.acceptDeathReportAlertByTransport(
          deathReportId: deathReportId);
    });
  }
}
