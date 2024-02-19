// import 'package:dartz/dartz.dart';
// import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
// import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
// import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
// import 'package:tdd_tutorial_flutter/src/authetication/data/datasources/authetication_remote_data_source.dart';
// import 'package:tdd_tutorial_flutter/src/authetication/domain/entities/user.dart';
// import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';

// class AuthenticationRepositoryImplementation
//     implements AutheticationRepository {
//   const AuthenticationRepositoryImplementation(this._remoteDataSource);
//   final AuthenticationRemoteDataSource _remoteDataSource;
//   ResultVoid createUser(
//       {required String createdAt,
//       required String name,
//       required String avatar}) async {
    
//     try{
//     await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
//     return const Right(null);
//     }on APIException catch(e){
//       return Left(ApiFailure.fromException(e));
//     }  
    
//     }

//   @override
//   ResultFuture<List<User>> getUsers() async {
//     try{
//     final result = await _remoteDataSource.getUsers();
//     return Right(result);
//     }on APIException catch(e){
//       return Left(ApiFailure.fromException(e));
//     }
//   }
// }
