import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/datasources/authetication_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial_flutter/src/authetication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/data/repositories/on_borading_repo_impl.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  //app logic
  // sl
  //   ..registerFactory(
  //     () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
  //   )

  //   //use cases
  //   ..registerLazySingleton(() => CreateUser(sl()))
  //   ..registerLazySingleton(() => GetUsers(sl()))

  //   //repositories
  //   ..registerLazySingleton<AutheticationRepository>(
  //       () => AuthenticationRepositoryImplementation(sl()))
  //   ..registerLazySingleton<AuthenticationRemoteDataSource>(
  //       () => AuthRemoteDataSrcImpl(sl()))

  //   //external dependencies
  //   ..registerLazySingleton(() => http.Client());

  sl
    ..registerFactory(
      () =>
          OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
        ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )

    //onboardind cubit

    //use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))

    //repositories
    ..registerLazySingleton<OnnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    //external dependencies
    ..registerLazySingleton(() => prefs)

    // authentication cubit

       //use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    //repositories
    ..registerLazySingleton<AutheticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    //external dependencies
    ..registerLazySingleton(() => http.Client());

}
