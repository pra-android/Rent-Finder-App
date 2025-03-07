import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';

import 'package:rentfinderapp/auth/login/login.dart';
import 'package:rentfinderapp/extras/constants/onboarding_constant.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IntroScreen(
        onbordingDataList: OnboardingConstant.list,
        colors: [
          //list of colors for per pages
          Colors.white,
          Colors.red,
        ],

        pageRoute: MaterialPageRoute(builder: (context) => LoginScreen()),
        nextButton: Text("NEXT", style: TextStyle(color: Colors.purple)),
        lastButton: Text("GOT IT", style: TextStyle(color: Colors.purple)),
        skipButton: Text("SKIP", style: TextStyle(color: Colors.purple)),
      ),
    );
  }
}
