import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:http/http.dart' as http;

abstract class SalesRemoteDataSource {
  Future<void> createSales(String userId, String variantId);

  Future<List<SalesModel>> getAllSales(String userId);

  Future<SalesModel> getSalesById(String salesId);

  Future<void> updateSales(SalesModel updateSale);

  Future<void> deleteSales(String salesId);
}

class SalesRemoteDataSourceImpl implements SalesRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<void> createSales(String userId, String variantId) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse(ApiConst.addSales);
      final data = {
        'userId': userId,
        'variantId': variantId,
      };

      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          body: jsonEncode(data));

      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSales(String salesId) async {
    try {
      String authToken = await token.then((value) => value!.token);

      final url = Uri.parse('${ApiConst.deleteSales}/$salesId');
      final res = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SalesModel>> getAllSales(String userId) async {
    try {
      final uri = Uri.parse(ApiConst.getAllSales);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => SalesModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw SalesNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SalesModel> getSalesById(String salesId) async {
    try {
      final uri = Uri.parse('${ApiConst.getOneSale}/$salesId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return SalesModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw SalesNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSales(SalesModel updateSale) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse("${ApiConst.updateSales}/${updateSale.id}");
      final body = jsonEncode(updateSale.tojson());
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
