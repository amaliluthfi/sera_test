part of 'session_bloc.dart';

@immutable
abstract class SessionState {}

class SessionInit extends SessionState {}

class SessionLoading extends SessionState {}

class SessionDone extends SessionState {
  SessionDone({this.successMessage});

  final String? successMessage;
}

class SessionFailed extends SessionState {
  SessionFailed({this.errorMessage});

  final String? errorMessage;
}
