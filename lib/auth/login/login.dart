import 'package:flutter/material.dart';
import 'package:rentfinderapp/auth/login/login_footer.dart';
import 'package:rentfinderapp/auth/login/login_form.dart';
import 'package:rentfinderapp/auth/login/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [LoginHeader(), LoginForm(), LoginFooter()],
          ),
        ),
      ),
    );
  }
}
