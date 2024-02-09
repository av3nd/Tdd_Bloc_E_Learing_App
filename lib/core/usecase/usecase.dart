

import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';

abstract class UsecasewithParams<Type, Params> {
  const UsecasewithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParamas<Type> {
  const UsecaseWithoutParamas();
  ResultFuture<Type> call();
}
