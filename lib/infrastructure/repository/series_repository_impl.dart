// Part d'infrastructura del repositori
// Implementa les funcionalitats de la classe abstracta ComarquesRepository
// Cal notar que a Dart no existeixen intefaces com a tal, però totes les
// classes poden actuar com a interfaces.
// La forma de definir una interface és declarant una classe abstracta
// i implementant els mètodes d'aquesta.


import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';
import 'package:exercici_disseny_responsiu_stateful/domain/repositories/series_repositori.dart';
import '../data_sources/series_api.dart';
import '../mappers/serie_mapper.dart';

class SerieRepositoryImpl implements SerieRepository {
  // Referència a l'API remota
  final SeriesApi remote;
  // L'API s'inicialitza en el constructor
  SerieRepositoryImpl(this.remote);

  @override
  Future<List<Serie>> getSeries() async {
    try {
      // Posem l'await per esperar-nos a obtenir la resposta
      final jsonSeries = await remote.getSeries();
      return jsonSeries
          .map((serieJSON) => SerieMapper.fromJson(serieJSON))
          .toList();
    } catch (e) {
      print("\x1B[31mError al recuperar las series: $e\x1B[0m");
      return [];
    }
  }

}
