import 'package:exercici_disseny_responsiu_stateful/presentation/navigation/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class FavSeriesScreen extends StatefulWidget {
  const FavSeriesScreen({super.key});

  @override
  State<FavSeriesScreen> createState() => _FavSeriesScreenState();
}

class _FavSeriesScreenState extends State<FavSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Series Favoritas')),
      body: const Center(child: Text('Series Favoritas'),),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 2),
    );
  }
  
}