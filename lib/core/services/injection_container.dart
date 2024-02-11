import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/datasources/authetication_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/authetication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial_flutter/src/authetication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial_flutter/src/authetication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  //app logic
  sl..registerFactory(() => AuthenticationCubit(createUser: sl(), getUsers: sl()))

  //use cases
  ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    //repositories
      ..registerLazySingleton<AutheticationRepository>(()=>AuthenticationRepositoryImplementation(sl()))
        ..registerLazySingleton<AuthenticationRemoteDataSource>(()=> AuthRemoteDataSrcImpl(sl()))
          
          //external dependencies
          ..registerLazySingleton(() => http.Client.new);

}