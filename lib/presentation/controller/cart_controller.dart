import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/get_cart_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/create_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/delete_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/get_sales_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/update_sales_usecase.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  late Cart currentCart;
  late Sales currentSale;
  List<Sales> cartSales = [];

  double totalPrice = 0.0;

  Future<Cart> getUserCart(String userId) async {
    cartSales = [];
    final res = await GetCartByIdUsecase(sl())(userId: userId);
    res.fold((l) => null, (r) => currentCart = r);
    await getCartSales();
    return currentCart;
  }

  Future<void> addUserCart(String userId) async {
    await CreateCartUsecase(sl())(userId: userId);
  }

  Future<void> updateUserCart(Cart newCart) async {
    await UpdateCartUsecase(sl())(cart: newCart);
  }

  Future<List<Sales>> getCartSales() async {
    cartSales = [];
    for (var x in currentCart.sales) {
      final res = await GetSalesByIdUsecase(sl())(salesId: x);
      res.fold((l) => null, (r) {
        cartSales.add(r);
      });
    }
    return cartSales;
  }

  // Future<Variant> getCartVariants(String variantId) async {
  //   Variant? result;
  //   final res = await GetVariantByIdUsecase(sl())(variantId: variantId);
  //   res.fold((l) => null, (r) {
  //     return result = r;
  //   });
  // }

  // Future<void> incrementSaleQuantity(String saleId) async {
  //   final WatchController watchController = Get.find();
  //   final Sales sale = cartSales.firstWhere((element) => element.id == saleId);
  //   if (sale.quantity <
  //       cartSales
  //           .firstWhere((element) => sale.variantId == element.id)
  //           .quantity) {
  //     sale.quantity++;
  //     sale.totalprice = double.parse((watchController.getPrice(watchController
  //                 .allWatchs
  //                 .firstWhere((element) => element.id == sale.productId)) *
  //             sale.quantity)
  //         .toStringAsFixed(2));
  //     await UpdateSalesUsecase(sl())(sale);
  //   }
  //   getReclamationPrice();
  //   update([ControllerID.SALE_QUANTITY]);
  // }

  // List<String> get getCartSalesId => cartSales.map((e) => e.id!).toList();
  // List<String> get getCartVariant => cartSales.map((e) => e.variantId).toList();

  // Future addSale(Sales newSale) async {
  //   print('sales tracking add sale${newSale.variantId}');
  //   if (!getCartVariant.contains(newSale.variantId)) {
  //     final addsale = await UpdateSalesUsecase(sl()).call(newSale);
  //     addsale.fold((l) => null, (r) async {
  //       cartSales.add(r);
  //       await _updateSailes();
  //     });
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: 'watch already in cart!',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.TOP,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Color(0xFFAF6767),
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //   await getUserCart(newSale.userId);
  //   update();
  // }

  // Future _updateSailes() async {
  //   currentCart.sales = getCartSalesId;
  //   await UpdateCartUsecase(sl()).call(cart: currentCart);
  //   update();
  // }

  // Future deleteSale(String saleId) async {
  //   await DeleteSalesUsecase(sl())(salesId: saleId);
  //   cartSales.removeWhere((element) => element.id == saleId);
  //   currentCart.sales = getCartSalesId;
  //   await _updateSailes();
  //   await getUserCart(currentCart.userId);
  //   update();
  // }

  // Future clearCart() async {
  //   cartSales = [];
  //   await _updateSailes();
  // }
}
