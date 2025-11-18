import '../../domain/entities/Video.dart';

class VideoMapper {

  static Video fromJson(Map<String, dynamic> json) {
    return Video(id: json["id"],
    title: json["title"] ?? "",
    topic: json["topic"] ?? "",
    description: json["description"] ?? "",
    duration: json["duration"] ?? "",
    thumbnail: json["thumbnail"] ?? "");
  }

}