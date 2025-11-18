import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_container_widget.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_list_widget.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/Video.dart';
import '../../domain/usecase/GetVideoUseCase.dart';
import '../../infrastructure/repository/videos_repository_impl.dart';
import '../../infrastructure/data_sources/videos_api.dart';




class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  late GetVideosUseCase _getVideosUseCase;
  List<Video> _videos = [];
  bool _isLoading = true;
  Map<String, dynamic>? _selectedFilm;

  @override
  void initState() {
    super.initState();
    
    //Cadema completa(API -> Repo -> UseCase)
    //VideosApi sabe cómo pedir los datos del backend.
    //VideoRepositoryImpl usa esa API para obtener vídeos.
    //GetVideosUseCase se apoya en el repositorio.
    final api = VideosApi('http://127.0.0.1:8080/api/videolist/');
    final repo = VideoRepositoryImpl(api);
    _getVideosUseCase = GetVideosUseCase(repo);

    _loadVideos();

  }
  
  Future<void> _loadVideos() async {
    final videos = await _getVideosUseCase();
    setState((){
      _videos = videos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // Convert domain Video objects to simple maps expected by the existing widgets
    final items = _videos
        .map((v) => {
              'id': v.id,
              'topic': v.topic ?? '',
              'description': v.description ?? '',
              'duration': v.duration?.toString() ?? '',
              // MyContainerWidget expects a 'cover' key for the image
              'cover': "assets/images/thumbnails/${v.thumbnail}",
            })
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Películas')),
      body: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 720; // breakpoint

        // Detail panel (may be null)
        final detail = Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyContainerWidget(film: _selectedFilm),
        );

        // List panel
        final list = Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyListWidget(
            items: items,
            callback: (item) {
              setState(() {
                _selectedFilm = Map<String, dynamic>.from(item);
              });
            },
          ),
        );

        if (isWide) {
          // Side-by-side on wide screens: detail on the left, list on the right
          return Row(
            children: [
              Flexible(flex: 2, child: detail),
              const VerticalDivider(width: 1),
              Flexible(flex: 3, child: list),
            ],
          );
        }

        // Narrow screens: detail above, list below. Keep list scrollable.
        return Column(
          children: [
            // Make the detail area take a proportional height but not exceed a sensible max
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              child: SizedBox(width: double.infinity, child: detail),
            ),
            Expanded(child: list),
          ],
        );
      }),
    );
  }
}


