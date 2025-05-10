import 'package:flutter/material.dart';
import 'package:examen_1/models/proveedores.dart';
import 'package:examen_1/services/provider_service.dart';
import 'package:provider/provider.dart';

class ListProviderScreen extends StatelessWidget {
  const ListProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    if (providerService.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      body: ListView.builder(
        itemCount: providerService.providers.length,
        itemBuilder: (context, index) {
          final provider = providerService.providers[index];
          return ListTile(
            title: Text('${provider.providerName} ${provider.providerLastName}'),
            subtitle: Text(provider.providerMail),
            onTap: () {
              providerService.selectedProvider = provider.copy();
              Navigator.pushNamed(context, 'edit_provider');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          providerService.selectedProvider = ProveedorItem(
            providerId: 0,
            providerName: '',
            providerLastName: '',
            providerMail: '',
            providerState: 'Activo',
          );
          Navigator.pushNamed(context, 'edit_provider');
        },
      ),
    );
  }
}
