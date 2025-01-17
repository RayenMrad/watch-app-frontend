import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/models/variant_model.dart';
import 'package:http/http.dart' as http;

abstract class VariantRemoteDataSource {
  Future<List<VariantModel>> getAllVariant();
}

class VariantRemoteDataSourceImpl implements VariantRemoteDataSource {
  @override
  Future<List<VariantModel>> getAllVariant() async {
    try {
      final uri = Uri.parse(ApiConst.getAllVariant);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => VariantModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw ProductNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
