abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState({
    required this.message,
  });
}

class LoggedOutHomeState extends HomeState {}
