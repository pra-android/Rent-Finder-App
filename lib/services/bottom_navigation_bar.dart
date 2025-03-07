import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentfinderapp/providers/bottom_navigation_provider.dart';
import 'package:rentfinderapp/extras/theme_provider.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme mode from the theme provider
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    // Define the colors based on theme mode
    final selectedItemColor = isDarkMode ? Colors.grey.shade700 : Colors.purple;
    final unselectedItemColor = isDarkMode ? Colors.white : Colors.black;

    return BottomNavigationBar(
      selectedItemColor: selectedItemColor, // Change based on theme mode
      unselectedItemColor: unselectedItemColor, // Change based on theme mode
      showUnselectedLabels: true,
      onTap: (int index) {
        ref.read(bottomNavigationCounter.notifier).state = index;
      },
      currentIndex: ref.watch(bottomNavigationCounter),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color:
                isDarkMode
                    ? Colors.white
                    : Colors.black, // Icon color based on theme
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_outline,
            color:
                isDarkMode
                    ? Colors.white
                    : Colors.black, // Icon color based on theme
          ),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore_outlined,
            color:
                isDarkMode
                    ? Colors.white
                    : Colors.black, // Icon color based on theme
          ),
          label: "Post Rent",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.person,
            color:
                isDarkMode
                    ? Colors.white
                    : Colors.black, // Icon color based on theme
          ),
          label: "Account",
        ),
      ],
    );
  }
}
