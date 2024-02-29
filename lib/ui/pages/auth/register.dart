import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_project/ui/common/app_button.dart';
import 'package:flutter_auth_project/ui/common/app_text_field.dart';
import 'package:flutter_auth_project/ui/common/loader.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_bloc.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_events.dart';
import 'package:flutter_auth_project/ui/pages/auth/bloc/auth_states.dart';
import 'package:flutter_auth_project/ui/pages/auth/login.dart';
import 'package:flutter_auth_project/utils/app_colors.dart';
import 'package:flutter_auth_project/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onRegisterTap() {
    final isValidated = _formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    BlocProvider.of<AuthBloc>(context).add(
      RegisterAuthEvent(
        name: name,
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: _listenToState,
      bloc: BlocProvider.of<AuthBloc>(context),
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
            label: 'Enter your name',
            controller: _nameController,
            validate: Validators.text,
          ),
          const SizedBox(
            height: 10,
          ),
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
                label: 'Register',
                onTap: _onRegisterTap,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _buildLoginText(),
        ],
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already registered? ',
        ),
        InkWell(
          onTap: () => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const Login(),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
        )
      ],
    );
  }
}
