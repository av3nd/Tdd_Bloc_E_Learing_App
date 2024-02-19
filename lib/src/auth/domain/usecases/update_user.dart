import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/enums/update_user.dart';
import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/repos/auth_repo.dart';

class UpdateUser extends UsecasewithParams<void, UpdateUserParams>{
  const UpdateUser(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
    action: params.action,
    userData: params.userData,
  );
}

class UpdateUserParams extends Equatable{
  const UpdateUserParams({required this.action,required this.userData});

  const UpdateUserParams.empty()
    :this(action: UpdateUserAction.displayName,userData: '');

  final UpdateUserAction action;
  final dynamic userData;
  
  @override
  List<dynamic> get props => [action,userData];

  
}