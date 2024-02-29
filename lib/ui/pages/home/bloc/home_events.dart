abstract class HomeEvent {}

class LogoutHomeEvent extends HomeEvent {}

class ErrorHomeEvent extends HomeEvent {
  final String message;

  ErrorHomeEvent({
    required this.message,
  });
}
