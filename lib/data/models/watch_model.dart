import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:flutter/foundation.dart';

class WatchModel extends Watch {
  const WatchModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.price,
      required super.brand,
      required super.reference,
      required super.description,
      required super.size});

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
      brand: json['brand'],
      reference: json['reference'],
      description: json['description'],
      size: json['size']);

  Map<String, dynamic> tojson() => {
        '_id': id,
        'name': name,
        'image': image,
        'price': price,
        'brand': brand,
        'reference': reference,
        'description': description,
        'size': size,
      };
}
