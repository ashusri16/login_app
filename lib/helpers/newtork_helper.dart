import 'package:connectivity/connectivity.dart';

class Connection {
  static Connectivity get connectivity => Connectivity();

  static Future<bool> isConnected() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none)
      return false;
    else
      return true;
  }
}
