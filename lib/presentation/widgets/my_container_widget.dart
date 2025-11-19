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
    return SingleChildScrollView(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: film == null
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Selecciona una pel·lícula de la llista'),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // 👈 perquè la portada ocupe tot l’ample
                children: [
                  // 🔹 Portada a dalt (ample complet). Canvia l’aspect ratio al teu gust.
                  // 16/9 sol quedar bé per a “banner”; si vols look de pòster usa 2/3 i afegeix un límit d’alçada.
                  isImageDisplayed
                      ? _CoverFullWidth(
                          cover: (film!['cover'] as String?)?.trim(),
                        )
                      : _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),

                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),

                  // 🔹 Textos i accions, amb padding intern
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // evita overflows verticals
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (film!['title'] ?? '—').toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${film!['topic'] ?? '—'} · ${formattedTime(timeInSecondS: film!['duration'])}',
                        ),
                        // Aquí podries afegir botons (Acció / Neteja) si vols
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CoverFullWidth extends StatelessWidget {
  const _CoverFullWidth({required this.cover});
  final String? cover;

  @override
  Widget build(BuildContext context) {
    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);

    // Si vols “pòster” alt, posa aspectRatio: 2/3 i limita alçada amb ConstrainedBox.
    // Si vols “banner”, deixa 16/9.
    const aspect = 16 / 9;

    final Widget child = (cover == null || cover!.isEmpty)
        ? Container(
            color: placeholderColor,
            child: const Icon(Icons.image_not_supported),
          )
        : Image.network(
            cover!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            loadingBuilder: (c, w, p) => p == null
                ? w
                : const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
          );

    return SizedBox(
      width: double.infinity,
      child: AspectRatio(aspectRatio: aspect, child: child),
    );

    // 👉 Si prefereixes look “pòster” sense que es faça massa alt:
    // return ConstrainedBox(
    //   constraints: const BoxConstraints(maxHeight: 240), // límit d’alçada
    //   child: SizedBox(
    //     width: double.infinity,
    //     child: AspectRatio(aspectRatio: 2/3, child: child),
    //   ),
    // );
  }
}
