import 'package:flutter/material.dart';
import '../models/proveedores.dart';

class ProviderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProveedorItem provider;

  ProviderFormProvider(this.provider);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
