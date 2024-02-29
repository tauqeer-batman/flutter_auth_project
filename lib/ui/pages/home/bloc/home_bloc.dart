import 'package:flutter_auth_project/services/auth_service.dart';
import 'package:flutter_auth_project/services/service_locator.dart';
import 'package:flutter_auth_project/ui/pages/home/bloc/home_events.dart';
import 'package:flutter_auth_project/ui/pages/home/bloc/home_states.dart';
import 'package:flutter_auth_project/utils/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<HomeEvent>((event, emit) async {
      if (event is LogoutHomeEvent) {
        await _logoutUser(emit);
      } else if (event is ErrorHomeEvent) {
        emit(
          ErrorHomeState(
            message: event.message,
          ),
        );
      }
    });
  }

  Future<void> _logoutUser(Emitter<HomeState> emit) async {
    await performSafeAction(() async {
      emit(
        LoadingHomeState(),
      );
      await locator<AuthService>().logout();
      emit(
        LoggedOutHomeState(),
      );
    });
  }

  @override
  void onCatch(String message) {
    add(
      ErrorHomeEvent(
        message: message,
      ),
    );
  }
}
