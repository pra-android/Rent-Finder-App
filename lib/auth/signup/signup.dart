import 'package:flutter/material.dart';
import 'package:rentfinderapp/auth/signup/signup_footer.dart';
import 'package:rentfinderapp/auth/signup/signup_form.dart';
import 'package:rentfinderapp/auth/signup/signup_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [SignUpHeader(), SignupForm(), SignupFooter()]),
      ),
    );
  }
}
