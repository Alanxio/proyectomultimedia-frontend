

import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';

abstract class SerieRepository {
  
  Future<List<Serie>> getSeries();


}
