import 'package:flutter/material.dart';

class MyListSeriesWidget extends StatelessWidget {
  const MyListSeriesWidget({
    super.key,
    required this.items,
    required this.callback,
  });

  final List items;
  final Function callback;

  static const url = 'http://localhost:8080';

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(url + items[index]["cover"]),
            title: Text(items[index]["title"]),
            subtitle: Text('Eps:${(items[index]['listaVideo']).length}'),
            onTap: () {
              callback(items[index]);
            },
          );
        },
      ),
    );
  }
}
