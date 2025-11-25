import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyContainerWidget extends StatefulWidget {
  final dynamic film;

  const MyContainerWidget({super.key, this.film});

  @override
  State<MyContainerWidget> createState() => _MyContainerWidgetScreenState();
}

class _MyContainerWidgetScreenState extends State<MyContainerWidget> {
  late VideoPlayerController _controller;
  Map<String, dynamic>? film;
  static const url = 'http://localhost:8080';
  bool isPlaying = false;
  bool isImageDisplayed = false;

  @override
  void initState() {
    super.initState();

    film = widget.film;

    if (film == null || film!['id'] == null) return;

    final urlfilm = film!['id'];

    final urlTotal = url + urlfilm;

    _controller = VideoPlayerController.networkUrl(Uri.parse(urlTotal))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant MyContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.film != oldWidget.film) {
      setState(() {
        film = widget.film;
      });

      final urlfilm = film!['id'];

      final urlTotal = url + urlfilm;

      // Reiniciar el vídeo
      if (film != null && film!['id'] != null) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(urlTotal))
          ..initialize().then((_) {
            setState(() {});
          });
      }
    }
  }

  formattedTime({required String timeInSecondS}) {
    double timeInSecond = double.parse(timeInSecondS);
    int sec = (timeInSecond % 60).floor();
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) {
    if (film == null) {
      return const Center(
        child: Text('Selecciona una pel·lícula de la llista'),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Video ocupa más espacio
          Expanded(
            flex: 3,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      fit: StackFit
                          .expand, //IMPORTANTE, ocupa TODO el tamaño del vídeo
                      children: [
                        VideoPlayer(_controller),

                        Center(
                          // Boton play/pause ahora centrado
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Barra de progreso pegada abajo
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ValueListenableBuilder(
                            valueListenable: _controller,
                            builder: (context, VideoPlayerValue value, _) {
                              final position = value.position.inMilliseconds
                                  .toDouble();
                              final duration = value.duration.inMilliseconds
                                  .toDouble();

                              if (duration <= 0) return SizedBox.shrink();

                              return Slider(
                                min: 0,
                                max: duration,
                                value: position.clamp(0, duration),
                                onChanged: (newValue) {
                                  _controller.seekTo(
                                    Duration(milliseconds: newValue.toInt()),
                                  );
                                },
                                activeColor: Colors.red,
                                inactiveColor: Colors.white38,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          // Información debajo del video
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film!['title'],
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 3, // PERMITE QUE EL TÍTULO USE HASTA 3 LÍNEAS
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  '${film!['topic']} · ${formattedTime(timeInSecondS: film!['duration'])}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
