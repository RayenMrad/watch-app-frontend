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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: DrawerContents(), // Your custom drawer content
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Header Section
              Header(
                title: "Cart Page",
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                },
              ),
              // Cart Content
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Container(
                    color: Colors.black,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GetBuilder<CartController>(
                            init: CartController(),
                            builder: (cartController) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: cartController
                                          .currentCart.sales.length,
                                      itemBuilder: (context, index) {
                                        // Render a CartWatchList widget for each sale
                                        return const CartWatchList();
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Shrink the Column to its content
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors
                                                .black, // Set background color to black
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize
                                                .min, // Shrink the Row to its content
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // Center content horizontally
                                            children: [
                                              const Text(
                                                "Total Price : ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              const Text(
                                                "4000 dt ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: 340,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentMethodScreen()),
                                              );
                                            },
                                            child: const Text(
                                              "Continue",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),

                      // The widget showing the watch list
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
