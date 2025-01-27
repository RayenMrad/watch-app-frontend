import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:clean_arch/domain/usecases/variant_usecases/get_one_variant_usecase.dart';
import 'package:clean_arch/domain/usecases/variant_usecases/get_all_variant_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/delete_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  late Wishlist currentWishlist;
  List<Variant> wishlistModel = [];

  Future<Wishlist> getWishList(String userId) async {
    final res = await GetWishlistUsecase(sl())(wishlistId: userId);
    res.fold((l) => null, (r) => currentWishlist = r);
    await getWishlistTextures();
    return currentWishlist;
  }

  Future<void> addUserWishlist(String userId) async {
    await CreateWishListUsecase(sl())(userId: userId);
  }

  Future<void> updateUserWishlist(Wishlist newWishList) async {
    await UpdateWishListUsecase(sl())(wishlist: newWishList);
  }

  Future<List<Variant>> getWishlistTextures() async {
    wishlistModel = [];
    for (var element in currentWishlist.watchs) {
      final res = await GetOneVariant(sl())(element);
      res.fold((l) => null, (r) => wishlistModel.add(r));
    }
    return wishlistModel;
  }

  bool likedProduct(String textureId) {
    return getWishlistIds.contains(textureId);
  }

  List<String> get getWishlistIds => wishlistModel.map((e) => e.id).toList();

  Future toggleLikedTexture(Variant texture) async {
    if (wishlistModel.contains(texture)) {
      wishlistModel.remove(texture);
    } else {
      wishlistModel.add(texture);
    }
    currentWishlist.watchs = getWishlistIds;
    await updateUserWishlist(currentWishlist);
    update([ControllerID.LIKE_PRODUCT]);
  }
}
