import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';

abstract class Failure extends Equatable{
final String message;
final dynamic statusCode;
String get errorMessage => '$statusCode Error:$message';

Failure({required this.message, required this.statusCode})
  : assert(
    statusCode is String || statusCode is int,
    'StatusCode cannot be a ${statusCode.runtimeType}',
  );
@override
List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure{
   ApiFailure({required super.message, required super.statusCode});
   ApiFailure.fromException(APIException exception) : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure{
   CacheFailure({required super.message, required super.statusCode});
}