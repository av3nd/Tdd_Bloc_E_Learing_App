import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';

class SignIn extends UsecasewithParams<LocalUser, SignInParams>{
  const SignIn(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repo.signIn(
    email:params.email, password:params.password);
}

class SignInParams extends Equatable{
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
    : email = '',
    password = '';

  final String email;
  final String password;
  
  @override
  List<String> get props => [email,password];
}