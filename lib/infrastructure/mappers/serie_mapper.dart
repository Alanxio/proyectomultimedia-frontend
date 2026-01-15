import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';

class SerieMapper {

  static Serie fromJson(Map<String, dynamic> json) {
    return Serie(id: json["id"],
    title: json["titulo"] ?? "",
    description: json["descripcion"] ?? "",
    fechaRegistro: json["fecha_registro"],
    fechaMod: json["fecha_modificacion"],
    listaVideo: json["videos"] as List);
  }

}
