import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/command_model.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class CommandRemoteDataSource {
  Future<void> createCommand(String userId, List<Sales> sales);
  Future<CommandModel> getCommandById(String commandId);
  Future<void> cancelCommand(String commandId);
}

class CommandRemoteDataSourceImpl implements CommandRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<void> cancelCommand(String commandId) {
    // TODO: implement cancelCommand
    throw UnimplementedError();
  }

  @override
  Future<void> createCommand(String userId, List<Sales> sales) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse(ApiConst.addCommand);
      final body = jsonEncode({
        'userId': userId,
        'sales': sales.map((sales) => (sales as SalesModel).tojson()).toList(),
      });
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to create command");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommandModel> getCommandById(String commandId) async {
    try {
      final uri = Uri.parse('${ApiConst.getOneCommand}/$commandId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return CommandModel.fromJson(body);
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
