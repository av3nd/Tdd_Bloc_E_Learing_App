

import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/repos/exam_repo.dart';

class GetUserExams extends FutureUsecaseWithoutParams<List<UserExam>> {
  const GetUserExams(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<UserExam>> call() => _repo.getUserExams();
}
