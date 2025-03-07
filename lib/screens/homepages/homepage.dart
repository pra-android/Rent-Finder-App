import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentfinderapp/screens/homepages/homepage_footer.dart';
import 'package:rentfinderapp/screens/homepages/homepage_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(children: [HomepageHeader(), HomePageFooter()]),
    );
  }
}
