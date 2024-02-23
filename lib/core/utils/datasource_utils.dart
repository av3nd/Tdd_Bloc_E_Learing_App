
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';

class DataSourceUtils {
  const DataSourceUtils._();

  static Future<void> authorizeUser(FirebaseAuth auth) async {
    final user = auth.currentUser;
    if (user == null) {
      throw const APIException(
        message: 'User is not authenticated',
        statusCode: '401',
      );
    }
  }
}
