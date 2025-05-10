import 'dart:convert';

class Proveedor {
  Proveedor({required this.listado});
  List<ProveedorItem> listado;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
    listado: List<ProveedorItem>.from(json["Listado"].map((x) => ProveedorItem.fromMap(x))),
  );
}

class ProveedorItem {
  ProveedorItem({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  int providerId;
  String providerName;
  String providerLastName;
  String providerMail;
  String providerState;

  factory ProveedorItem.fromMap(Map<String, dynamic> json) => ProveedorItem(
    providerId: json["provider_id"],
    providerName: json["provider_name"],
    providerLastName: json["provider_last_name"],
    providerMail: json["provider_mail"],
    providerState: json["provider_state"],
  );

  Map<String, dynamic> toJson() => {
    "provider_id": providerId,
    "provider_name": providerName,
    "provider_last_name": providerLastName,
    "provider_mail": providerMail,
    "provider_state": providerState,
  };

  ProveedorItem copy() => ProveedorItem(
    providerId: providerId,
    providerName: providerName,
    providerLastName: providerLastName,
    providerMail: providerMail,
    providerState: providerState,
  );

  Map<String, dynamic> toMap() => {
  "provider_id": providerId.toString(),
  "provider_name": providerName,
  "provider_last_name": providerLastName,
  "provider_mail": providerMail,
  "provider_state": providerState,
};
}
