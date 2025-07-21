class MercadoPagoTax {
  double? value;
  String? type;

  MercadoPagoTax();

  static List<MercadoPagoTax> fromJsonList(List<dynamic> jsonList) {
    List<MercadoPagoTax> toList = [];

    for (var item in jsonList) {
      MercadoPagoTax model = MercadoPagoTax.fromJson(item);
      toList.add(model);
    }

    return toList;
  }

  MercadoPagoTax.fromJson(Map<String, dynamic> json) {
    value =
        (json['value'] != null) ? double.parse(json['value'].toString()) : 0;
    type = json['type'];
  }

  Map<String, dynamic> toJson() => {'value': value.toString(), 'type': type};
}
