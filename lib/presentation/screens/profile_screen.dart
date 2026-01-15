import 'package:exercici_disseny_responsiu_stateful/presentation/navigation/app_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Center(child: Text('Perfil'),),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 3),
    );
  }
  
}