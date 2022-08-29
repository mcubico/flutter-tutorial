import 'package:flutter/material.dart';

class InputsView extends StatelessWidget {
  const InputsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs & Forms'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  hintText: 'Nombres del usuario',
                  helperText: 'Solo letras',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido';
                  }

                  if (value.length < 3) {
                    return 'El nombre debe tener mínimo 3 caracteres.';
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
