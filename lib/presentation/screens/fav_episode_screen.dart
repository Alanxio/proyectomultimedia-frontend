import 'package:exercici_disseny_responsiu_stateful/presentation/navigation/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class FavEpisodeScreen extends StatefulWidget {
  const FavEpisodeScreen({super.key});

  @override
  State<FavEpisodeScreen> createState() => _FavEpisodeScreenState();
}

class _FavEpisodeScreenState extends State<FavEpisodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Episodios Favoritos')),
      body: const Center(child: Text('Episodios Favoritos'),),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 1),
    );
  }
  
}