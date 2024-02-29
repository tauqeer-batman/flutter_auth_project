import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_project/ui/common/app_button.dart';
import 'package:flutter_auth_project/ui/common/app_text_field.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_bloc.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_events.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_states.dart';
import 'package:flutter_auth_project/ui/pages/home/home.dart';
import 'package:flutter_auth_project/utils/app_colors.dart';
import 'package:flutter_auth_project/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/loader.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onLoginTapped() {
    final isValidated = _formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    BlocProvider.of<AuthBloc>(context).add(
      LoginAuthEvent(
        email: email,
        password: password,
      ),
    );
  }

  void _listenToState(BuildContext context, AuthState state) {
    if (state is ErrorAuthState) {
      Fluttertoast.showToast(
        msg: state.message,
      );
    } else if (state is SuccessAuthState) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const Home(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _listenToState,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            label: 'Enter your email',
            controller: _emailController,
            validate: Validators.email,
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextField(
            label: 'Enter your password',
            controller: _passwordController,
            validate: Validators.password,
            hideText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is LoadingAuthState) {
                return const Loader();
              }
              return AppButton(
                label: 'Login',
                onTap: _onLoginTapped,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _buildRegisterText(),
        ],
      ),
    );
  }

  Widget _buildRegisterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New to this app? ',
        ),
        InkWell(
          onTap: () => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const Register(),
            ),
          ),
          child: const Text(
            'Register here',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
