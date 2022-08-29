import 'package:flutter/material.dart';

class ListViewSecondView extends StatelessWidget {
  const ListViewSecondView({Key? key}) : super(key: key);

  final options = const ['Megaman', 'Metal Gear', 'Super Smash', 'Iron Man'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Listview'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        itemCount: options.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(options[index]),
          trailing:
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.indigo),
          onTap: () {},
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
