import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';

class SignUp extends UsecasewithParams<void, SignUpParams>{
  const SignUp(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
    email: params.email,
    password: params.password,
    fullName: params.fullName,
  );


}

  class SignUpParams extends Equatable{
    const SignUpParams({
      required this.email,
      required this.password,
      required this.fullName,
    });

    const SignUpParams.empty() : this(email: '', password: '', fullName: '');

    final String email;
    final String password;
    final String fullName;

    @override 
    List<String> get props => [email,password,fullName];
  }
