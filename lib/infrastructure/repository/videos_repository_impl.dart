// Part d'infrastructura del repositori
// Implementa les funcionalitats de la classe abstracta ComarquesRepository
// Cal notar que a Dart no existeixen intefaces com a tal, però totes les
// classes poden actuar com a interfaces.
// La forma de definir una interface és declarant una classe abstracta
// i implementant els mètodes d'aquesta.


import '../../domain/entities/Video.dart';
import '../../domain/repositories/videos_repositori.dart';
import '../data_sources/videos_api.dart';
import '../mappers/Video_mapper.dart';

class VideoRepositoryImpl implements VideoRepository {
  // Referència a l'API remota
  final VideosApi remote;
  // L'API s'inicialitza en el constructor
  VideoRepositoryImpl(this.remote);

  @override
  Future<List<Video>> getVideos() async {
    try {
      // Posem l'await per esperar-nos a obtenir la resposta
      final jsonVideos = await remote.getVideos();
      return jsonVideos
          .map((videoJSON) => VideoMapper.fromJson(videoJSON))
          .toList();
    } catch (e) {
      print("\x1B[31mError al recuperar los videos: $e\x1B[0m");
      return [];
    }
  }

}
