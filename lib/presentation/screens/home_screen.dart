import 'package:exercici_disseny_responsiu_stateful/presentation/navigation/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 0),
    );
  }
}
