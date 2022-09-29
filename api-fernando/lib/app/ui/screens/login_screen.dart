import 'package:apifernando/app/data/services/notification_service.dart';
import 'package:apifernando/app/data/services/services.dart';
import 'package:apifernando/app/domain/helpers/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apifernando/app/domain/providers/providers.dart';
import 'package:apifernando/app/ui/helpers/helpers.dart';
import 'package:apifernando/app/ui/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
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
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }

              String pattern = emailRegexp;
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
            onChanged: (value) => loginForm.password = value,
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

                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    final bool loginSuccessful = await authService.login(
                      email: loginForm.email,
                      password: loginForm.password,
                    );

                    loginForm.isLoading = false;
                    if (!loginSuccessful) {
                      NotificationService.showSnackBar(
                          'User or password wrong');
                      return;
                    }

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
