

import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/repos/exam_repo.dart';

class SubmitExam extends FutureUsecaseWithParams<void, UserExam> {
  const SubmitExam(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<void> call(UserExam params) => _repo.submitExam(params);
}
