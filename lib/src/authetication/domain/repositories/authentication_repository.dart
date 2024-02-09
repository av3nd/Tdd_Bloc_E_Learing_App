import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/entities/user.dart';

abstract class AutheticationRepository{
  const AutheticationRepository();

  ResultVoid createUser({
   required String createdAt,
   required String name,
   required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}