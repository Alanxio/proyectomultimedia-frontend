// ignore_for_file: file_names

import '../../domain/entities/Video.dart';

class VideoMapper {

  static Video fromJson(Map<String, dynamic> json) {
    return Video(id: json["id"],
    title: json["titulo"] ?? "",
    description: json["descripcion"] ?? "",
    duration: json["duracion"] ?? "",
    fechaRegistro: json["fecha_registro"],
    fechaMod: json["fecha_modificacion"],
    autor: json["autor"],
    /*seriePertenecer: json["serie_id"]?? "",*/
    numEpisodio: json["num_episodio"]?? "",
    resolution: json["resolucion"]);
  }

}

  // String id;
  // String? title;
  // String? description;
  // double? duration;
  // String? fechaRegistro;
  // String? autor;
  // String? subReq;
  // String? thumbnail;
  // Serie? seriePertenecer;
  // int? numEpisodio;
  // String? resolution;