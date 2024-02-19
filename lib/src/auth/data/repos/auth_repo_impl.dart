import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial_flutter/core/enums/update_user.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      await _remoteDataSource.signUp(
          email: email, fullName: fullName, password: password);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser(
      {required UpdateUserAction action,dynamic userData}) async {
    try {
      await _remoteDataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
