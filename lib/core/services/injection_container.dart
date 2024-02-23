import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_tutorial_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/auth/data/repos/auth_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/usecases/forgot_password.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/usecases/sign_in.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/usecases/sign_up.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/usecases/update_user.dart';
import 'package:tdd_tutorial_flutter/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_tutorial_flutter/src/chat/data/datasources/chat_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/chat/data/repos/chat_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/repos/chat_repo.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/get_groups.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/get_messages.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/get_user_by_id.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/join_group.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/leave_group.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/usecases/send_message.dart';
import 'package:tdd_tutorial_flutter/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/data/datasources/course_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/data/repos/course_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/repos/course_repo.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/usecases/add_course.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/usecases/get_course.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/data/repos/exam_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/repos/exam_repo.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/get_exam_questions.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/get_exams.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/get_user_course_exams.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/get_user_exams.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/submit_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/update_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/usecases/upload_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/data/repos/material_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/repos/material_repo.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/usecases/add_material.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/domain/usecases/get_materials.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/presentation/app/providers/resource_controller.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/data/repos/video_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/domain/usecases/get_video.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/presentation/cubit/course_cubit.dart';
import 'package:tdd_tutorial_flutter/src/notifications/data/datasources/notification_remote_data_src.dart';
import 'package:tdd_tutorial_flutter/src/notifications/data/repos/notification_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/repos/notification_repo.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/usecases/clear.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/usecases/clear_all.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/usecases/get_notifications.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/usecases/mark_as_read.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/usecases/send_notification.dart';
import 'package:tdd_tutorial_flutter/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/data/repositories/on_borading_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initChat();
   await _initCourse();
  await _initVideo();
  await _initMaterial();
  await _initExam();
  await _initNotifications();

}

Future<void> _initNotifications() async {
  sl
    ..registerFactory(
      () => NotificationCubit(
        clear: sl(),
        clearAll: sl(),
        getNotifications: sl(),
        markAsRead: sl(),
        sendNotification: sl(),
      ),
    )
    ..registerLazySingleton(() => Clear(sl()))
    ..registerLazySingleton(() => ClearAll(sl()))
    ..registerLazySingleton(() => GetNotifications(sl()))
    ..registerLazySingleton(() => MarkAsRead(sl()))
    ..registerLazySingleton(() => SendNotification(sl()))
    ..registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(sl()))
    ..registerLazySingleton<NotificationRemoteDataSrc>(
      () => NotificationRemoteDataSrcImpl(firestore: sl(), auth: sl()),
    );
}

Future<void> _initExam() async {
  sl
    ..registerFactory(
      () => ExamCubit(
        getExamQuestions: sl(),
        getExams: sl(),
        submitExam: sl(),
        updateExam: sl(),
        uploadExam: sl(),
        getUserCourseExams: sl(),
        getUserExams: sl(),
      ),
    )
    ..registerLazySingleton(() => GetExamQuestions(sl()))
    ..registerLazySingleton(() => GetExams(sl()))
    ..registerLazySingleton(() => SubmitExam(sl()))
    ..registerLazySingleton(() => UpdateExam(sl()))
    ..registerLazySingleton(() => UploadExam(sl()))
    ..registerLazySingleton(() => GetUserCourseExams(sl()))
    ..registerLazySingleton(() => GetUserExams(sl()))
    ..registerLazySingleton<ExamRepo>(() => ExamRepoImpl(sl()))
    ..registerLazySingleton<ExamRemoteDataSrc>(
      () => ExamRemoteDataSrcImpl(auth: sl(), firestore: sl()),
    );
}

Future<void> _initMaterial() async {
  sl
    ..registerFactory(
      () => MaterialCubit(
        addMaterial: sl(),
        getMaterials: sl(),
      ),
    )
    ..registerLazySingleton(() => AddMaterial(sl()))
    ..registerLazySingleton(() => GetMaterials(sl()))
    ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(sl()))
    ..registerLazySingleton<MaterialRemoteDataSrc>(
      () => MaterialRemoteDataSrcImpl(
        firestore: sl(),
        auth: sl(),
        storage: sl(),
      ),
    )
    ..registerFactory(() => ResourceController(storage: sl(), prefs: sl()));
}

Future<void> _initVideo() async {
  sl
    ..registerFactory(() => VideoCubit(addVideo: sl(), getVideos: sl()))
    ..registerLazySingleton(() => AddVideo(sl()))
    ..registerLazySingleton(() => GetVideos(sl()))
    ..registerLazySingleton<VideoRepo>(() => VideoRepoImpl(sl()))
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: sl(), auth: sl(), storage: sl()),
    );
}

Future<void> _initCourse() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        addCourse: sl(),
        getCourses: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(sl()))
    ..registerLazySingleton(() => GetCourses(sl()))
    ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(sl()))
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firestore: sl(),
        storage: sl(),
        auth: sl(),
      ),
    );
}

Future<void> _initChat() async {
  sl
    ..registerFactory(
      () => ChatCubit(
        getGroups: sl(),
        getMessages: sl(),
        getUserById: sl(),
        joinGroup: sl(),
        leaveGroup: sl(),
        sendMessage: sl(),
      ),
    )
    ..registerLazySingleton(() => GetGroups(sl()))
    ..registerLazySingleton(() => GetMessages(sl()))
    ..registerLazySingleton(() => GetUserById(sl()))
    ..registerLazySingleton(() => JoinGroup(sl()))
    ..registerLazySingleton(() => LeaveGroup(sl()))
    ..registerLazySingleton(() => SendMessage(sl()))
    ..registerLazySingleton<ChatRepo>(() => ChatRepoImpl(sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(firestore: sl(), auth: sl()),
    );
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
          signIn: sl(), forgotPassword: sl(), signUp: sl(), updateUser: sl()),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    //use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))

    //repositories
    ..registerLazySingleton<OnnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    //external dependencies
    ..registerLazySingleton(() => prefs);
}
