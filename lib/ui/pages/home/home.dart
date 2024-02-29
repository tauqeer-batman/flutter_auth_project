import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_project/services/auth_service.dart';
import 'package:flutter_auth_project/services/service_locator.dart';
import 'package:flutter_auth_project/ui/common/app_button.dart';
import 'package:flutter_auth_project/ui/common/loader.dart';
import 'package:flutter_auth_project/ui/pages/auth/login.dart';
import 'package:flutter_auth_project/ui/pages/home/bloc/home_events.dart';
import 'package:flutter_auth_project/ui/pages/home/bloc/home_states.dart';
import 'package:flutter_auth_project/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _listenToState(BuildContext context, HomeState state) {
    if (state is ErrorHomeState) {
      Fluttertoast.showToast(
        msg: state.message,
      );
    } else if (state is LoggedOutHomeState) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const Login(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final displayName = locator<AuthService>().getDisplayName();
    return BlocListener(
      bloc: BlocProvider.of<HomeBloc>(context),
      listener: _listenToState,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (displayName != null)
              Text(
                'Welcome, $displayName',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),
            if (displayName != null)
              const SizedBox(
                height: 20,
              ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: BlocProvider.of<HomeBloc>(context),
              builder: (context, state) {
                if (state is LoadingHomeState) {
                  return const Loader();
                }
                return AppButton(
                  label: 'Logout',
                  onTap: () => BlocProvider.of<HomeBloc>(context).add(
                    LogoutHomeEvent(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
