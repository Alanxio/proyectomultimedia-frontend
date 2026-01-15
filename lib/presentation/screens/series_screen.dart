import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';
import 'package:exercici_disseny_responsiu_stateful/domain/usecase/get_serie_usecase.dart';
import 'package:exercici_disseny_responsiu_stateful/infrastructure/data_sources/series_api.dart';
import 'package:exercici_disseny_responsiu_stateful/infrastructure/repository/series_repository_impl.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/screens/serie_detalls_screen.dart';
import 'package:exercici_disseny_responsiu_stateful/presentation/widgets/my_list_series_widget.dart';
import 'package:flutter/material.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  late GetSeriesUseCase _getSeriesUseCase;
  List<Serie> _series = [];
  bool _isLoading = true;
  Map<String, dynamic>? _selectedSerie;

  @override
  void initState() {
    super.initState();

    final api = SeriesApi('http://localhost:8090/catalogo/series');
    final repo = SerieRepositoryImpl(api);
    _getSeriesUseCase = GetSeriesUseCase(repo);

    _loadSeries();
  }

  Future<void> _loadSeries() async {
    final series = await _getSeriesUseCase();
    setState(() {
      _series = series;
      _isLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final items = _series
        .map(
          (s) => {
            'id': s.id,
            'title': s.title ?? '',
            'fechaRegistro': s.fechaRegistro?.toString() ?? '',
            'cover': '/thumb_series/${s.id}.png',
            'description': s.description ?? '',
            'fechaMod': s.fechaMod?.toString() ?? '',
            'listaVideo': s.listaVideo?.toList() ?? [],
          },
        )
        .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyListSeriesWidget(
          items: items,
          callback: (item) {
            setState(() {
              _selectedSerie = Map<String, dynamic>.from(item);
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeriesDetallScreen(serie: _selectedSerie),
              ),
            );
          },
        ),
      ),
    );
  }
}
