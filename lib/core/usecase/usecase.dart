

import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';

abstract class UsecasewithParams<Type, Params> {
  const UsecasewithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParamas<Type> {
  const UsecaseWithoutParamas();
  ResultFuture<Type> call();
}

abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  ResultFuture<Type> call();
}
abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  ResultStream<Type> call();
}
abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  ResultStream<Type> call(Params params);
}
