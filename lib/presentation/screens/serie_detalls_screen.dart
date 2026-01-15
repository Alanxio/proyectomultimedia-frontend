import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_list_widget.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/Video.dart';
import '../../domain/usecase/GetVideoUseCase.dart';
import '../../infrastructure/repository/videos_repository_impl.dart';
import '../../infrastructure/data_sources/videos_api.dart';
import 'video_player_screen.dart'; // Agrega esta línea arriba



class SeriesDetallScreen extends StatefulWidget {
  final Map<String, dynamic>? serie;

  const SeriesDetallScreen({super.key, required this.serie});

  @override
  State<SeriesDetallScreen> createState() => _SerieDetallScreenState();
}



class _SerieDetallScreenState extends State<SeriesDetallScreen> {
  late GetVideosUseCase _getVideosUseCase;
  List<Video> _videos = [];
  bool _isLoading = true;
  late Map<String, dynamic>? serie = widget.serie;
  late int idSerie = serie?["id"];
  

  @override
  void initState() {
    super.initState();
    
    //Cadema completa(API -> Repo -> UseCase)
    //VideosApi sabe cómo pedir los datos del backend.
    //VideoRepositoryImpl usa esa API para obtener vídeos.
    //GetVideosUseCase se apoya en el repositorio.
    final api = VideosApi('http://localhost:8090/catalogo/serie/$idSerie/episodios');
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
    // Convertir objetos de dominio Video en mapas simples esperados por los widgets existentes
    final items = _videos
        .map((v) => {
              'id': v.id,
              'title': v.title ?? '',
              'description': v.description ?? '',
              'duration': v.duration?.toString() ?? '',
              'fechaRegistro': v.fechaRegistro?.toString() ?? '',
              'fechaMod': v.fechaMod?.toString() ?? '',
              'autor': v.autor ?? '',
              'cover': '/thumbnails/${v.id}.png',
              'resolution': v.resolution ?? '',
              'numEpisodio': v.numEpisodio ?? '',
              'url': 'http://127.0.0.1:8080/videos/${v.id}/index.m3u8'
            })
        .toList();

    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(8.0), child: MyListWidget(items: items, callback: (item){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(film: item)));
      }) ,)
    );
  }
}


