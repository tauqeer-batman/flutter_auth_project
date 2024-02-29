import 'package:flutter/material.dart';
import 'package:flutter_auth_project/ui/pages/auth/splash.dart';
import 'package:flutter_auth_project/ui/pages/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/pages/auth/bloc/auth_bloc.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splash(),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthBloc(),
            ),
            BlocProvider(
              create: (_) => HomeBloc(),
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
