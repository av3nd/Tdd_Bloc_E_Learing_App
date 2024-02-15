import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';

abstract class OnnBoardingRepo {
  const OnnBoardingRepo();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
