import 'package:clean_arch/domain/enteties/sales.dart';

class SalesModel extends Sales {
  SalesModel(
      {required super.id,
      required super.quantity,
      required super.totalprice,
      required super.userId,
      required super.variantId});

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
        id: json['_id'],
        quantity: json['quantity'],
        totalprice: double.parse(json['totalPrice'].toString()),
        userId: json['userId'],
        variantId: json['variantId'],
      );

  Map<String, dynamic> tojson() => {
        'quantity': quantity,
        'totalprice': totalprice,
        'userId': userId,
        'variantid': variantId
      };
}
