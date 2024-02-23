

import 'package:tdd_tutorial_flutter/core/usecase/usecase.dart';
import 'package:tdd_tutorial_flutter/core/utils/typedef.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/entities/notification.dart';
import 'package:tdd_tutorial_flutter/src/notifications/domain/repos/notification_repo.dart';

class SendNotification extends FutureUsecaseWithParams<void, Notification> {
  const SendNotification(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(Notification params) =>
      _repo.sendNotification(params);
}
