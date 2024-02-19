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
