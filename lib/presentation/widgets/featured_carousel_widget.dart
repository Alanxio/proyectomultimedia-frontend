import 'dart:async';
import 'package:exercici_disseny_responsiu_stateful/domain/entities/serie.dart';
import 'package:flutter/material.dart';

class FeaturedCarouselWidget extends StatefulWidget {
  final List<Serie> series;

  const FeaturedCarouselWidget({super.key, required this.series});

  @override
  State<FeaturedCarouselWidget> createState() => _FeaturedCarouselWidgetState();
}

class  _FeaturedCarouselWidgetState extends State<FeaturedCarouselWidget> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_controller.hasClients) {
        _currentIndex = (_currentIndex + 1) % widget.series.length;

        _controller.animateToPage(_currentIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder( controller: _controller,
          itemCount: widget.series.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final serie = widget.series[index];
          },
        )
        )
      ],
    );
  }
  
}