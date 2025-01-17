import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/models/watch_model.dart';
import 'package:http/http.dart' as http;

abstract class WatchRemoteDataSource {
  Future<List<WatchModel>> getAllWatchs();
  Future<WatchModel> getWatch(String wID);
  Future<List<WatchModel>> getWatchsByCat(String wCat);
}

class WatchRemoteDataSourceImpl implements WatchRemoteDataSource {
  @override
  Future<WatchModel> getWatch(String wID) async {
    try {
      final uri = Uri.parse('${ApiConst.getOnewatch}/$wID');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return WatchModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WatchModel>> getAllWatchs() async {
    try {
      final uri = Uri.parse(ApiConst.getAllWatchs);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => WatchModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WatchModel>> getWatchsByCat(String wCat) async {
    try {
      final uri = Uri.parse('${ApiConst.getWatchsByCat}/$wCat');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => WatchModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
