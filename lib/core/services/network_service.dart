import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// NOTE:Network connection is being checked by the internet connection checker here
/// so you don't have to put it in your code. It will throw an error if you try to
/// put NetworkInfo in your code.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  InternetConnectionCheckerPlus connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
