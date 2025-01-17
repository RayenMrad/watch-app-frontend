import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/models/wishlist_model.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> getWishList(String wishlistId);
  Future<void> createWishList(String userId, List<Watch> watchs);
  Future<void> updateWishlist(String wishlistId);
  Future<void> deleteWishlist(String wishlistId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  @override
  Future<void> createWishList(String userId, List<Watch> watchs) {
    // TODO: implement createWishList
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWishlist(String wishlistId) {
    // TODO: implement deleteWishlist
    throw UnimplementedError();
  }

  @override
  Future<WishlistModel> getWishList(String wishlistId) async {
    try {
      final uri = Uri.parse(ApiConst.getOneWishList);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return body.map((e) => WishlistModel.fromJson(e));
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
  Future<void> updateWishlist(String wishlistId) {
    // TODO: implement updateWishlist
    throw UnimplementedError();
  }
}
