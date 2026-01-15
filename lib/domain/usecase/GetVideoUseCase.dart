// ignore_for_file: file_names

import '../repositories/videos_repositori.dart';
import '../entities/Video.dart';

class GetVideosUseCase {

  final VideoRepository repository;

  GetVideosUseCase(this.repository);

  Future<List<Video>> call() async {
    return await repository.getVideos();
  }

}