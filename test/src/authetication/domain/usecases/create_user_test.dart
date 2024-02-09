import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUser usecase;
  late AutheticationRepository repository;
  final params = CreateUserParams.empty();

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  test('should call the [AuthRepo.createUser]', () async {
    //arrange
    //stub
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    //act
    final result = await usecase(params);

    //assert
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(() => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);

        verifyNoMoreInteractions(repository);
  });
}
