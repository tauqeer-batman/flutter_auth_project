import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_auth_project/exceptions/auth_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  void onCatch(String message);

  Future<void> performSafeAction(
    AsyncCallback tryAction,
  ) async {
    try {
      await tryAction();
    } on FirebaseAuthException catch (e, s) {
      onCatch(e.message ?? 'Something went wrong!');
      log(e.message ?? e.code, stackTrace: s);
    } on AuthException catch (e) {
      onCatch(e.message);
      log(e.message);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      onCatch(e.toString());
    }
  }
}
