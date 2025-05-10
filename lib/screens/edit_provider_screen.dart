import 'package:flutter/material.dart';
import 'package:examen_1/services/provider_service.dart';
import 'package:examen_1/providers/provider_form_provider.dart';
import 'package:examen_1/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class EditProviderScreen extends StatelessWidget {
  const EditProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProviderFormProvider(providerService.selectedProvider!),
      child: _ProviderScreenBody(providerService: providerService),
    );
  }
}

class _ProviderScreenBody extends StatelessWidget {
  final ProviderService providerService;

  const _ProviderScreenBody({required this.providerService});

  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);
    final provider = providerForm.provider;

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Proveedor')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: providerForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: provider.providerName,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre',
                  labelText: 'Nombre',
                ),
                onChanged: (value) => provider.providerName = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: provider.providerLastName,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Apellido',
                  labelText: 'Apellido',
                ),
                onChanged: (value) => provider.providerLastName = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: provider.providerMail,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Correo',
                  labelText: 'Correo',
                ),
                onChanged: (value) => provider.providerMail = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: provider.providerState,
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Estado',
                  labelText: 'Estado',
                ),
                onChanged: (value) => provider.providerState = value,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'delete_provider',
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      if (!providerForm.isValidForm()) return;
                      providerService.deleteProvider(provider, context);
                    },
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: 'save_provider',
                    child: const Icon(Icons.save),
                    onPressed: () {
                      if (!providerForm.isValidForm()) return;
                      providerService.editOrCreateProvider(provider);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
