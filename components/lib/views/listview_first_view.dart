import 'package:flutter/material.dart';

class ListViewFirstView extends StatelessWidget {
  const ListViewFirstView({Key? key}) : super(key: key);

  final options = const ['Megaman', 'Metal Gear', 'Super Smash', 'Iron Man'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Listview'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ...options.map((data) => ListTile(
                title: Text(data),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ))
        ],
      ),
    );
  }
}
