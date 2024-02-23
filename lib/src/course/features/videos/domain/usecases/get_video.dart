

import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/domain/entities/video.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/domain/repos/video_repo.dart';

class GetVideos extends FutureUsecaseWithParams<List<Video>, String> {
  const GetVideos(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call(String params) => _repo.getVideos(params);
}
