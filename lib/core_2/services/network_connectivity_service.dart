import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityService {
  final _connectivity = Connectivity();

  /// Stream to listen for connectivity changes
  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged.map((results) {
        // Handle the list and return the first meaningful result
        if (results.contains(ConnectivityResult.mobile)) {
          return ConnectivityResult.mobile;
        } else if (results.contains(ConnectivityResult.wifi)) {
          return ConnectivityResult.wifi;
        } else if (results.contains(ConnectivityResult.ethernet)) {
          return ConnectivityResult.ethernet;
        }
        return ConnectivityResult.none;
      });

  /// Check current internet connection status
  Future<bool> hasInternetConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return !results.contains(ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }

  /// Get current connectivity status
  Future<ConnectivityResult> getConnectivityStatus() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.mobile)) {
        return ConnectivityResult.mobile;
      } else if (results.contains(ConnectivityResult.wifi)) {
        return ConnectivityResult.wifi;
      } else if (results.contains(ConnectivityResult.ethernet)) {
        return ConnectivityResult.ethernet;
      }
      return ConnectivityResult.none;
    } catch (e) {
      return ConnectivityResult.none;
    }
  }
}
