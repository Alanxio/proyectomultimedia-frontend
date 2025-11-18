import 'package:flutter/material.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget({super.key, required this.items, required this.callback});

  final List items;
  final Function callback;

  // Source - https://stackoverflow.com/a
  // Posted by Akash Lilhare, modified by community. See post 'Timeline' for change history
  // Retrieved 2025-11-11, License - CC BY-SA 4.0

  formattedTime({required String timeInSecondS}) {
    int timeInSecond = int.parse(timeInSecondS);
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) {
    // Llista d’exemple amb separadors
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(items[index]["cover"]),
            title: Text(items[index]["id"]),
            subtitle: Text(
                          '${items[index]['topic']} · ${formattedTime(timeInSecondS: items[index]['duration'])}',
                        ),
            onTap: () {
              callback(items[index]);
            },
          );
        },
      ),
    );
  }
}
