import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:formularios/app/domain/providers/providers.dart';
import 'package:formularios/app/ui/helpers/helpers.dart';
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

                    // Title
                    Text('Login', style: Theme.of(context).textTheme.headline4),

                    const SizedBox(height: 30),

                    // Form
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
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
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
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
            onChanged: (value) => loginForm.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }

              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value)
                  ? null
                  : 'El correo ingresado no es válido';
            },
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
            onChanged: (value) => loginForm.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }

              return null;
            },
          ),
          const SizedBox(height: 30),

          // Submit
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    // Se usa para quitar el teclado cuando se presione el botón
                    FocusScope.of(context).unfocus();

                    if (!loginForm.isValidForm()) {
                      return;
                    }

                    loginForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    loginForm.isLoading = false;

                    // Se usa pushReplacementNamed para que no se de la opción de
                    // regresar al login al usuario ya que se destruye el stack de las
                    // pantallas y establece el home como la pantalla inicial
                    Navigator.pushReplacementNamed(context, 'home');
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espera...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
