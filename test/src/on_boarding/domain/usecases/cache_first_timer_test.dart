import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/usecases/cache_first_timer.dart';

import 'on_boarding_repo.mock.dart';

void main(){
  late OnnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp((){
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test('should call the [OnBoardingRepo.cacheFirstTimer] and return the right data', 
  () async{
    when(()=> repo.cacheFirstTimer()).thenAnswer(
      (_) async => Left(
        ApiFailure(
          message: 'Unknown Error Occurred',
          statusCode: 500,
        ),
      ),
    );
    final result = await usecase();
    expect(result, equals(Left<Failure,dynamic>(ApiFailure(message: 'Unknown Error Occurred', statusCode: 500),),),);
  });
  verify(()=> repo.cacheFirstTimer()).called(1);
  verifyNoMoreInteractions(repo);
}