import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/entities/resource.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/repos/material_repo.dart';


class MaterialRepoImpl implements MaterialRepo {
  const MaterialRepoImpl(this._remoteDataSource);

  final MaterialRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<Resource>> getMaterials(String courseId) async {
    try {
      final result = await _remoteDataSource.getMaterials(courseId);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addMaterial(Resource material) async {
    try {
      await _remoteDataSource.addMaterial(material);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
