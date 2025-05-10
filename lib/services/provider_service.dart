import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/proveedores.dart';

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ProveedorItem> providers = [];
  ProveedorItem? selectedProvider;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadProviders();
  }

  loadProviders() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    try {
      final response = await http.get(url, headers: {'authorization': basicAuth});
      final providerMap = Proveedor.fromJson(response.body);
      providers = providerMap.listado;
    } catch (e) {
      print('>>> ERROR al parsear proveedores: $e');
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = false;
    notifyListeners();
  }

  editOrCreateProvider(ProveedorItem provider) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.providerId == 0) {
      await createProvider(provider);
    } else {
      await updateProvider(provider);
    }
    isEditCreate = false;
    notifyListeners();
  }

  updateProvider(ProveedorItem provider) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: provider.toMap(), headers: {'authorization': basicAuth});
  }

  createProvider(ProveedorItem provider) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: {
      "provider_name": provider.providerName,
      "provider_last_name": provider.providerLastName,
      "provider_mail": provider.providerMail,
      "provider_state": provider.providerState,
    }, headers: {'authorization': basicAuth});
    providers.add(provider);
  }

  deleteProvider(ProveedorItem provider, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    await http.post(url, body: {
      "provider_id": provider.providerId.toString(),
    }, headers: {'authorization': basicAuth});
    providers.clear();
    loadProviders();
    Navigator.of(context).pushNamed('list_provider');
  }
}
