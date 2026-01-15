import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';
import '../repositories/series_repositori.dart';

class GetSeriesUseCase {

  final SerieRepository repository;

  GetSeriesUseCase(this.repository);

  Future<List<Serie>> call() async {
    return await repository.getSeries();
  }

}