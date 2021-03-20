part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationRequested extends NotificationEvent {
  NotificationRequested();
  @override
  List<Object> get props => [];

  @override
  String toString() => ' NotificationRequested ';
}

class NotificationAuthenticationStatusChanged extends NotificationEvent {
  const NotificationAuthenticationStatusChanged({this.status});

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class NotificationIsRead extends NotificationEvent {
  const NotificationIsRead({this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
