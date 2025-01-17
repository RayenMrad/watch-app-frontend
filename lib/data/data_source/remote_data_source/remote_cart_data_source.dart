import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/cart_model.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<void> createCart(String userId);
  Future<void> updateCart(String cartId, List<Sales> sales);
  Future<CartModel> getCart(String cartId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  Future<TokenModel> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<void> createCart(String userId) async {
    try {
      String authToken = await token.then((value) => value.token);
      final url = Uri.parse(ApiConst.addCart);
      final body = jsonEncode({'userId': userId, 'sales': []});

      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to create cart");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartModel> getCart(String cartId) async {
    try {
      final url = Uri.parse('${ApiConst.getOneCart}/$cartId');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return CartModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw ProductNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCart(String cartId, List<Sales> sales) async {
    try {
      String authToken = await token.then((value) => value.token);
      final url = Uri.parse("${ApiConst.updateCart}/$cartId");
      final body = jsonEncode({
        "sales": sales.map((sale) => (sale as SalesModel).tojson()).toList(),
      });
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to update cart");
      }
    } catch (e) {
      rethrow;
    }
  }
}
