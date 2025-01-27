import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/cart_controller.dart';
import 'package:clean_arch/presentation/screens/payment-screens/payment-screen.dart';
import 'package:clean_arch/presentation/widgets/cart/cart-watchs-list.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/headers/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthenticationController authenticationController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      drawer: const Drawer(
        child: DrawerContents(), // Your custom drawer content
      ),
      body: Column(
        children: [
          // Header Section
          Header(
            title: "Cart Page",
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          // Cart Content
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<CartController>(
                    init: CartController(),
                    builder: (cartController) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          // Cart Watch List
                          Expanded(
                            child: FutureBuilder(
                              future: cartController
                                  .getUserCart(cartController.currentCart.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Error loading sales'),
                                  );
                                } else if (snapshot.hasData &&
                                    cartController
                                        .currentCart.sales.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount:
                                        cartController.currentCart.sales.length,
                                    itemBuilder: (context, index) {
                                      return CartWatchList(
                                          sales:
                                              cartController.cartSales[index]);
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('Cart is empty'),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Total Price and Continue Button
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Total Price:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "4000 dt",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentMethodScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
