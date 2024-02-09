import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/entities/user.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParamas<List<User>>{
  const GetUsers(this._repository);
  final AutheticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}