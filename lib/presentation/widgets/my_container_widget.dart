import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyContainerWidget extends StatefulWidget {
  final double height;
  final double width;
  final Map<String, dynamic>? film;

  const MyContainerWidget({
    super.key,
    this.height = 200,
    this.width = 400,
    this.film,
  });

  @override
  State<MyContainerWidget> createState() => _MyContainerWidgetState();
}

class _MyContainerWidgetState extends State<MyContainerWidget> {
  VideoPlayerController? _controller;
  ChewieController? _chewie;
  Map<String, dynamic>? film;

  @override
  void initState() {
    super.initState();
    _initVideo(widget.film);
  }

  @override
  void didUpdateWidget(MyContainerWidget videoAnterior) {
    super.didUpdateWidget(videoAnterior);

    if (videoAnterior.film != widget.film) {
      _initVideo(widget.film);
    }
  }

  void _initVideo(Map<String, dynamic>? film) async {
    // Tancar l'anterior si existix
    await _controller?.dispose();
    _chewie?.dispose();

    if (film == null || !film.containsKey('url') || film['url'] == null) {
      setState(() {
        return;
      });
    }

    final url = film!['url'] as String;

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(url),
    ); //Reprodueix el video

    await _controller!.initialize(); // esperem que carregue

    _chewie = ChewieController(
      //Aço són el botons del video
      videoPlayerController: _controller!, 
      autoPlay: false,
      looping: false,
      aspectRatio: _controller!.value.aspectRatio,
    );

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewie?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.film == null) {
      return SizedBox(
        child: const Center(child: Text('Selecciona una película')),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return SizedBox(child: const Center(child: CircularProgressIndicator()));
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: Chewie(controller: _chewie!),
    );
  }
}
