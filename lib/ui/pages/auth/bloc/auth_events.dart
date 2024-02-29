abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent({
    required this.email,
    required this.password,
  });
}

class RegisterAuthEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterAuthEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class ErrorAuthEvent extends AuthEvent {
  final String message;

  ErrorAuthEvent({
    required this.message,
  });
}
