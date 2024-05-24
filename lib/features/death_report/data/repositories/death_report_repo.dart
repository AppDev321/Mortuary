import '../../../../core/network/api_manager.dart';
import '../data_source/death_report_remote_source.dart';

class DeathReportRepo {
  final DeathReportRemoteSource remoteDataSource;
  final ApiManager apiManager;

  DeathReportRepo({
    required this.remoteDataSource,
    required this.apiManager,
  });

// Future<Session> login({
//   required String emailAddress,
//   required String password,
// }) async {
//   return apiManager.handleRequest(() async {
//     final session = await remoteDataSource.login(
//       emailAddress: emailAddress,
//       password: password,
//     );
//
//     if (session is! CustomError) {
//       await localDataSource.saveSession(session);
//     }
//     return session;
//   });
// }
//
//
}
