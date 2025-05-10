import 'package:flutter/material.dart';
import 'package:examen_1/screens/login_screen.dart';
import 'package:examen_1/services/auth_services.dart';
import 'package:examen_1/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:examen_1/providers/login_form_provider.dart';
import 'package:examen_1/ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                    Text('Registra una cuenta', style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _RegisterForm(),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                      child: const Text('¿Ya tienes una cuenta?, autentícate'),
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({super.key});

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
              return (value != null && value.length >= 4) ? null : 'Contraseña mínima de 4 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.orange,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthServices>(context, listen: false);

                    if (!loginForm.isValidForm()) return;

                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.create_user(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }

                    loginForm.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text('Registrar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
