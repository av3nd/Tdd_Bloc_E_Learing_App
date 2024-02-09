import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecasewithParams<void, CreateUserParams>{
  final AutheticationRepository _repository;
  CreateUser(this._repository);
  
  @override
  ResultFuture<void> call(CreateUserParams params) async => _repository.createUser(
    createdAt: params.createdAt, 
    name: params.name, 
    avatar: params.avatar);
  
}

class CreateUserParams extends Equatable{
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
    : this(
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar'
      );

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar
  });
  
  @override
  List<Object?> get props => [createdAt, name, avatar];
}