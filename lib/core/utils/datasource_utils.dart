import 'package:air_guard/core/errors/exceptions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataSourceUtils {
  DataSourceUtils._();

  static Future<void> authorizeUser(FirebaseAuth auth) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw const ServerException(
        message: 'User is not authenticated',
        statusCode: 'auth/unauthenticated',
      );
    }
  }

  static Future<void> checkInternetConnection(Connectivity connectivity) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw const ServerException(
        message:
            'No internet connection. Please check your network settings and try again.',
        statusCode: 'no_internet',
      );
    }
  }
}
