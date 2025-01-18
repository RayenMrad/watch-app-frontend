import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/token_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveUserInformations(TokenModel token);
  Future<TokenModel?> getUserInformations();
  Future<void> logout();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  @override
  Future<void> saveUserInformations(TokenModel token) async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, json.encode(token.toJson()));
    } catch (e) {
      throw LocalStorageException();
    }
  }

  @override
  Future<TokenModel> getUserInformations() async {
    try {
      final sp = await SharedPreferences.getInstance();
      print(sp.getString("access"));
      if (sp.getString(StringConst.SP_TOKEN_KEY) == '' ||
          sp.getString(StringConst.SP_TOKEN_KEY) == null) {
        return TokenModel.fromJson(const {
          "message": "login successful",
          "token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFqZWphQGdtYWlsLmNvbSIsImlhdCI6MTcxNTMzMTk4MCwiZXhwIjoxNzE1MzMyODgwfQ.PxitiEv-iSiob2fzgJ991y1m0JDhVYLWLj5cQfJF3Nk",
          "tokenExpiration": "2024-05-10 10:21:20",
          "Uid": "1111"
        });
      }
      final data = sp.getString(StringConst.SP_TOKEN_KEY);
      TokenModel token = TokenModel.fromJson(json.decode(data.toString()));
      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, '');
      print("logout");
      print(sp.getString("access"));
    } catch (e) {
      throw LocalStorageException();
    }
  }
}
