import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';
import 'package:rentfinderapp/firebase_options.dart';
import 'package:rentfinderapp/providers/login_provider.dart';
import 'package:rentfinderapp/screens/home_screen.dart';
import 'package:rentfinderapp/screens/onboardingscreen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final themeMode = ref.watch(themeProvider);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: authState.when(
            data: (user) {
              if (user == null) {
                return OnboardingScreen();
              } else {
                return HomeScreen();
              }
            },
            error:
                (err, stack) =>
                    Scaffold(body: Center(child: Text("Error: $err"))),
            loading: () {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          ),
        );
      },
    );
  }
}
