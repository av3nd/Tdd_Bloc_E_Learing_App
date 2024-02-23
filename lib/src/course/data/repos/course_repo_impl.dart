import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/data/datasources/course_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/entities/course.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/repos/course_repo.dart';


class CourseRepoImpl implements CourseRepo {
  const CourseRepoImpl(this._remoteDataSrc);

  final CourseRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on APIException catch(e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSrc.getCourses();
      return Right(courses);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
