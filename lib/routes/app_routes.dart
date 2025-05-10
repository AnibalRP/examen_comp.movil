import 'package:flutter/material.dart';
import 'package:examen_1/screens/login_screen.dart';
import 'package:examen_1/screens/register_screen.dart';
import 'package:examen_1/screens/list_product_screen.dart';
import 'package:examen_1/screens/edit_product_screen.dart';
import 'package:examen_1/screens/list_category_screen.dart';
import 'package:examen_1/screens/edit_category_screen.dart';
import 'package:examen_1/screens/list_provider_screen.dart';
import 'package:examen_1/screens/edit_provider_screen.dart';
import 'package:examen_1/screens/error_screen.dart';
import 'package:examen_1/screens/home_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (_) => const LoginScreen(),
    'add_user': (_) => const RegisterScreen(),
    'list': (_) => const ListProductScreen(),
    'edit': (_) => const EditProductScreen(),
    'list_category': (_) => const ListCategoryScreen(),
    'edit_category': (_) => const EditCategoryScreen(),
    'list_provider': (_) => const ListProviderScreen(),
    'edit_provider': (_) => const EditProviderScreen(),
    'home': (BuildContext context) => const HomeScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const ErrorScreen(),
    );
  }
}
