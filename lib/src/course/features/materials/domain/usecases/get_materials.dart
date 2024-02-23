

import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/entities/resource.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/repos/material_repo.dart';

class GetMaterials extends FutureUsecaseWithParams<List<Resource>, String> {
  const GetMaterials(this._repo);

  final MaterialRepo _repo;

  @override
  ResultFuture<List<Resource>> call(String params) =>
      _repo.getMaterials(params);
}
