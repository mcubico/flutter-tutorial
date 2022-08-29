import 'package:flutter/material.dart';

class AlertView extends StatelessWidget {
  const AlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlertView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showAlert(context),
          child: const Text('Show Alert'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.close),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alerta!!!'),
          content: const Text('Contenido'),
          actions: [
            TextButton(
              onPressed: () => navigateBack(context),
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  void navigateBack(BuildContext context) => Navigator.pop(context);
}
