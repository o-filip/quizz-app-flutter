
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityInfo {
  Future<bool> get isConnected;
}

class ConnectivityInfoImpl implements ConnectivityInfo {
  ConnectivityInfoImpl({
    required this.connectionChecker,
  });

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
