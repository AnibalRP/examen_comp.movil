import 'package:flutter/material.dart';
import 'package:examen_1/providers/login_form_provider.dart';
import 'package:examen_1/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:examen_1/widgets/widgets.dart';
import 'package:examen_1/ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, 'add_user'),
                      child: const Text('¿No tienes una cuenta?, Regístrate'),
                    )
                  ],
                ),
              ),
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
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecortions.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.email,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              return (value != null && value.contains('@')) ? null : 'Correo inválido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecortions.authInputDecoration(
              hinText: '********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4) ? null : 'mínimo 8 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: const Color.fromARGB(255, 130, 91, 146),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthServices>(context, listen: false);

                    if (!loginForm.isValidForm()) return;

                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      print(errorMessage);
                    }

                    loginForm.isLoading = false;
                  },
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: const Text('Ingresar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
