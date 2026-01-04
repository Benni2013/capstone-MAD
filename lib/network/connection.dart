import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class ConnectionUtils {
  static final Connectivity _connectivity = Connectivity();

  /// Checks if the device has an active network connection
  /// Returns true if connected via mobile data, or WiFi
  static Future<bool> isNetworkConnected() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      
      return connectivityResult.any((result) => 
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi
      );
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /// Stream that monitors real-time connectivity changes
  static Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((results) =>
      results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi 
        )
    );
  }
}