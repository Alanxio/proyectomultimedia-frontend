// ignore_for_file: file_names

//import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';

class Video {

  int id;
  String? title;
  String? description;
  double? duration;
  String? fechaRegistro;
  String? fechaMod;
  String? autor;
  String? thumbnail;
  //Serie? seriePertenecer;
  int? numEpisodio;
  String? resolution;

  //Constructor
  Video({required this.id, this.title, this.description, this.duration, this.fechaRegistro, this.fechaMod, this.autor, this.thumbnail, /*this.seriePertenecer,*/ this.numEpisodio, this.resolution});
}