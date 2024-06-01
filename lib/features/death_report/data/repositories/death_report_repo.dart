import 'package:mortuary/features/authentication/domain/enities/user_model.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_alert.dart';
import '../../domain/enities/death_report_detail_response.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/processing_center.dart';
import '../../domain/enities/report_a_death_response.dart';
import '../data_source/death_report_remote_source.dart';

abstract class DeathReportRepo {
  Future<ReportDeathResponse> initiateDeathReport(
      {required int deathBodyCount,
      required int locationId,
      required double lat,
      required double lng,
      required String address,
      required UserRole userRole});

  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole,bool isMorgueScannedProcessingDepartment,bool isEmergencyReceivedABody);

  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest, required UserRole userRole});

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole);
  Future<DeathReportDetailResponse> getDeathReportDetailsById({required int deathReportId,required UserRole userRole});

  Future<List<DeathReportAlert>> checkAnyAlertExits();

  Future<Map<String,dynamic>> acceptDeathReportAlertByTransport({required int deathReportId,required int deathCaseID});
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId,required  int processingUnitId,required int deathCaseID}) ;
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport({required int deathReportId,required  int processingUnitId , required int deathCaseID}) ;
  Future<void> updateSpaceAvailabilityStatusPU({required int status});

  Future<Map<String, dynamic>> postMorgueProcessingDepartmentData(
      {required String bodyScanCode,
      required String departmentScanCode,
      required String processingUnitId,
      required String processingDepartmentID,
      required UserRole userRole});


  Future<void> updatePoliceStation({required int stationId,required int deathReportId,required String bandCodeID,required List<int> stationPocIds}) ;

}

class DeathReportRepoImpl extends DeathReportRepo {
  final DeathReportRemoteSource remoteDataSource;
  final ApiManager apiManager;

  DeathReportRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });

  @override
  Future<ReportDeathResponse> initiateDeathReport(
      {required int deathBodyCount,
      required int locationId,
      required double lat,
      required double lng,
      required String address,
        required UserRole userRole}) async {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.initiateDeathReport(
          deathBodyCount, locationId, lat, lng, address,userRole);
    });
  }

  @override
  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole,
      bool isMorgueScannedProcessingDepartment,
         bool isEmergencyReceivedABody) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.postQRScanCode(qrCode,userRole,isMorgueScannedProcessingDepartment,isEmergencyReceivedABody);
    });
  }

  @override
  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest, required UserRole userRole}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.postDeathReportForm(
          formRequest: formRequest,userRole: userRole);
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
  Future<DeathReportDetailResponse> getDeathReportDetailsById(
      {required int deathReportId,required UserRole userRole}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.getDeathReportDetailsById(
          deathReportId: deathReportId,
      userRole: userRole);
    });
  }

  @override
  Future<Map<String, dynamic>> acceptDeathReportAlertByTransport({required int deathReportId,required int deathCaseID}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.acceptDeathReportAlertByTransport(
          deathReportId: deathReportId,
          deathCaseID: deathCaseID);
    });
  }

  @override
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport({required int deathReportId, required int processingUnitId,required int deathCaseID}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.dropBodyToProcessUnityByTransport(
          deathReportId: deathReportId,
        processingUnitId: processingUnitId,
        deathCaseID: deathCaseID
      );
    });
  }

  @override
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId, required int processingUnitId,required int deathCaseID}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.getDetailOfProcessUnit(
          deathReportId: deathReportId,
          processingUnitId: processingUnitId,
          deathCaseID: deathCaseID
      );
    });
  }

  @override
  Future<void> updateSpaceAvailabilityStatusPU({required int status}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.updateSpaceAvailabilityStatusPU(
          status:status
      );
    });
  }

  @override
  Future<Map<String, dynamic>> postMorgueProcessingDepartmentData({
    required String bodyScanCode,
    required String departmentScanCode,
    required String processingUnitId, required String processingDepartmentID,
    required UserRole userRole}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.postMorgueProcessingDepartmentData(
          bodyScanCode: bodyScanCode,
          departmentScanCode: departmentScanCode,
          processingUnitId: processingUnitId,
          processingDepartmentID: processingDepartmentID,
          userRole: userRole);
    });
  }

  @override
  Future<void> updatePoliceStation({required int stationId, required int deathReportId, required String bandCodeID,required List<int> stationPocIds}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.updatePoliceStation(
          stationId: stationId,
          deathReportId: deathReportId,
          bandCodeID: bandCodeID,
      stationPocIds: stationPocIds);
    });
  }
}
