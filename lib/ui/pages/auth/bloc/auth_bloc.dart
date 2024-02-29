import 'dart:developer';

import 'package:flutter_auth_project/services/auth_service.dart';
import 'package:flutter_auth_project/services/service_locator.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_events.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_states.dart';
import 'package:flutter_auth_project/utils/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginAuthEvent) {
        await _loginUser(event.email, event.password, emit);
      } else if (event is RegisterAuthEvent) {
        await _registerUser(
          event.name,
          event.email,
          event.password,
          emit,
        );
      } else if (event is ErrorAuthEvent) {
        emit(
          ErrorAuthState(
            message: event.message,
          ),
        );
      }
    });
  }

  Future<void> _loginUser(
    String email,
    String password,
    Emitter<AuthState> emit,
  ) async {
    await performSafeAction(() async {
      emit(
        LoadingAuthState(),
      );
      final user = await locator<AuthService>().login(
        email: email,
        password: password,
      );
      log('Logged in: ${user?.email}');
      emit(
        SuccessAuthState(),
      );
    });
  }

  Future<void> _registerUser(
    String name,
    String email,
    String password,
    Emitter<AuthState> emit,
  ) async {
    await performSafeAction(() async {
      emit(
        LoadingAuthState(),
      );
      final user = await locator<AuthService>().register(
        name: name,
        email: email,
        password: password,
      );
      log('Registered: ${user?.displayName}');
      emit(
        SuccessAuthState(),
      );
    });
  }

  @override
  void onCatch(String message) {
    add(
      ErrorAuthEvent(message: message),
    );
  }
}
