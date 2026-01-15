import 'package:exercici_disseny_responsiu_stateful/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/screens/profile_screen.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/screens/fav_episode_screen.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/screens/fav_series_screen.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FavEpisodeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FavSeriesScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => _onTap(context, index),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: ''),
        NavigationDestination(icon: Icon(Icons.favorite_outline),selectedIcon: Icon(Icons.favorite), label: ''),
        NavigationDestination(icon: Icon(Icons.bookmark_outline), selectedIcon: Icon(Icons.bookmark), label: ''),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
