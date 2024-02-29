import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_project/ui/pages/home/home.dart';
import 'package:flutter_auth_project/utils/app_colors.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentUser = FirebaseAuth.instance.currentUser;
      late Widget child;
      if (currentUser == null) {
        child = const Login();
      } else {
        child = const Home();
      }
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => child,
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(
              AppColors.secondary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'LOADING...',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w200,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
