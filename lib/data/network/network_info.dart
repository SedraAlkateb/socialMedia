import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    try {
      // استخدام internetStatus للتحقق من الاتصال وتحويله إلى bool
      var status = await connectionChecker.internetStatus;
      return status == InternetStatus.connected;
    } catch (e) {
      print('Error checking internet connection: $e');
      return false;
    }
  }
}
