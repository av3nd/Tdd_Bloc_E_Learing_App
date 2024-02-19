import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UsecasewithParams<void, String>{
  const ForgotPassword(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);

  
}