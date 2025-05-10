import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _ModuleButton(
              label: 'Productos',
              icon: Icons.shopping_bag,
              routeName: 'list',
            ),
            const SizedBox(height: 20),
            _ModuleButton(
              label: 'Categorías',
              icon: Icons.category,
              routeName: 'list_category',
            ),
            const SizedBox(height: 20),
            _ModuleButton(
              label: 'Proveedores',
              icon: Icons.people,
              routeName: 'list_provider',
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String routeName;

  const _ModuleButton({
    required this.label,
    required this.icon,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
      ),
      onPressed: () => Navigator.pushNamed(context, routeName),
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
