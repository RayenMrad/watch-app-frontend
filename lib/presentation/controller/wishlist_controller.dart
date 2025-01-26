import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/delete_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  late Wishlist currentWishlist;

  Future<Wishlist> getWishList(String wishlistId) async {
    final res = await GetWishlistUsecase(sl())(wishlistId: wishlistId);
    res.fold((l) => null, (r) => currentWishlist = r);
    return currentWishlist;
  }

  // Future<Wishlist?> getWishList(String wishlistId) async {
  //   final res = await GetWishlistUsecase(sl())(wishlistId: wishlistId);

  //   Wishlist? wisshlist = res.fold(
  //     (l) {
  //       Fluttertoast.showToast(
  //         msg: l.message ?? "Failed to fetch wishlist",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.TOP,
  //         backgroundColor: Color(0xFFAF6767),
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //       return null;
  //     },
  //     (r) {
  //       currentWishlist = r;
  //       return r;
  //     },
  //   );
  //   return wisshlist;
  // }

  Future<void> createWishList(String userId) async {
    await CreateWishListUsecase(sl())(userId: userId);
  }

  Future<void> updateWishlist(Wishlist wishlist) async {
    await UpdateWishListUsecase(sl())(wishlist: wishlist);
  }

  Future<void> deleteWishlist(String wishlistId) async {
    await DeleteWishListUsecase(sl())(wishlistId: wishlistId);
  }
}
