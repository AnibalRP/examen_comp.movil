import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_1/services/auth_services.dart';
import 'package:examen_1/services/product_service.dart';
import 'package:examen_1/services/category_service.dart';
import 'package:examen_1/services/provider_service.dart';
import 'package:examen_1/providers/cart_provider.dart';
import 'package:examen_1/routes/app_routes.dart';
import 'package:examen_1/theme/theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => ProviderService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen 1',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}

