import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial_flutter/core/errors/exceptions.dart';
import 'package:tdd_tutorial_flutter/core/errors/failure.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial_flutter/src/chat/data/datasources/chat_remote_data_source.dart';
import 'package:tdd_tutorial_flutter/src/chat/data/models/group_model.dart';
import 'package:tdd_tutorial_flutter/src/chat/data/models/message_model.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/entities/group.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/entities/message.dart';
import 'package:tdd_tutorial_flutter/src/chat/domain/repos/chat_repo.dart';


class ChatRepoImpl implements ChatRepo {
  const ChatRepoImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  ResultStream<List<Group>> getGroups() {
    return _remoteDataSource.getGroups().transform(
          StreamTransformer<List<GroupModel>,
              Either<Failure, List<Group>>>.fromHandlers(
            handleError: (error, stackTrace, sink) {
              if (error is APIException) {
                sink.add(
                  Left(
                    ApiFailure(
                      message: error.message,
                      statusCode: error.statusCode,
                    ),
                  ),
                );
              } else {
                // Handle other types of exceptions as needed
                sink.add(
                  Left(
                    ApiFailure(
                      message: error.toString(),
                      statusCode: 500,
                    ),
                  ),
                );
              }
            },
            handleData: (groups, sink) {
              sink.add(Right(groups));
            },
          ),
        );
  }

  @override
  ResultFuture<void> sendMessage(Message message) async {
    try {
      await _remoteDataSource.sendMessage(message);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<Message>> getMessages(String groupId) {
    return _remoteDataSource.getMessages(groupId).transform(_handleStream());
  }

  StreamTransformer<List<MessageModel>, Either<Failure, List<Message>>>
      _handleStream() {
    return StreamTransformer<List<MessageModel>,
        Either<Failure, List<Message>>>.fromHandlers(
      handleError: (error, stackTrace, sink) {
        if (error is APIException) {
          sink.add(
            Left(
              ApiFailure(
                message: error.message,
                statusCode: error.statusCode,
              ),
            ),
          );
        } else {
          // Handle other types of exceptions as needed
          sink.add(
            Left(
              ApiFailure(
                message: error.toString(),
                statusCode: 500,
              ),
            ),
          );
        }
      },
      handleData: (messages, sink) {
        sink.add(Right(messages));
      },
    );
  }

  @override
  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.joinGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.leaveGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> getUserById(String userId) async {
    try {
      final result = await _remoteDataSource.getUserById(userId);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
