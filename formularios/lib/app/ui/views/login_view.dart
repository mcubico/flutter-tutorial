import 'package:flutter/material.dart';
import 'package:formularios/app/ui/helpers/input_decoration_helper.dart';
import 'package:formularios/app/ui/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainerWidget(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                    const _LoginForm(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorationHelper.authInputDecoration(
            hintText: 'joe.doe@email.com',
            labelText: 'Correo Electrónico',
            prefixIcon: Icons.alternate_email_rounded,
          ),
        ),
        const SizedBox(height: 30),

        // Password
        TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorationHelper.authInputDecoration(
            hintText: '********',
            labelText: 'Contraseña',
            prefixIcon: Icons.lock_outline,
          ),
        ),
        const SizedBox(height: 30),

        // Submit
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: Colors.deepPurple,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text(
              'Ingresar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
