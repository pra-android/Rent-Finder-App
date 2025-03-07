import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentfinderapp/extras/constants/pages_list.dart';
import 'package:rentfinderapp/providers/bottom_navigation_provider.dart';
import 'package:rentfinderapp/services/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer(
        builder: (context, ref, child) {
          return PagesList.pagesList[ref.watch(bottomNavigationCounter)];
        },
      ),

      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
