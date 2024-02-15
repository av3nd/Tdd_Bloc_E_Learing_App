import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/repositories/on_boarding_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParamas<void>{
  const CacheFirstTimer(this._repo);
  final OnnBoardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}