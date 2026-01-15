import 'package:flutter/material.dart';
import '../widgets/my_container_widget.dart';

class VideoPlayerScreen extends StatelessWidget {
  final Map<String, dynamic> film;

  const VideoPlayerScreen({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film['title'] ?? 'Reproductor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reproductor usando MyContainerWidget
            Expanded(
              child: MyContainerWidget(
                film: film,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            // Mostrar datos del video
            Text(
              film['title'] ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Tema: ${film['topic'] ?? ''}'),
            Text('Descripción: ${film['description'] ?? ''}'),
            Text('Duración: ${film['duration'] ?? ''}'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
