import 'package:clean_arch/presentation/controller/category_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/signUp-page.dart';
import 'package:clean_arch/presentation/screens/cat-screen.dart';
import 'package:clean_arch/presentation/screens/fetch-watchs.dart';
import 'package:clean_arch/presentation/screens/watch-screen.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/headers/header.dart';
import 'package:clean_arch/presentation/widgets/headers/home_select_header.dart';
import 'package:clean_arch/presentation/widgets/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerContents(),
      ),
      body: Column(
        children: [
          Header(
            title: 'Home Page',
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Discover Timeless Elegance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Find the perfect watch to match your style",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF9F9F9F),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // First Header and Grid
                      HomeSelectHeader(
                        categoryTitle: 'Categories',
                        onSeeAllPressed: () {},
                        seeAll: false,
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<CategoryController>(
                        init: CategoryController(),
                        builder: (controller) {
                          return SizedBox(
                            height: 60,
                            child: FutureBuilder(
                              future: controller.getAllCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.allCategories.length,
                                    itemBuilder: (_, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFAF6767),
                                          border: Border.all(
                                            color: Color(0xFFAF6767),
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            controller
                                                .allCategories[index].name,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else {
                                  return const Center(
                                      child: Text('Error loading categories'));
                                }
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Second Header and Grid
                      HomeSelectHeader(
                        categoryTitle: 'Top Deals',
                        onSeeAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Fetchwatchs(
                          itemCount: 4,
                          futureFunction:
                              WatchController().getSortedWatchsBySales()),

                      const SizedBox(height: 20),
                      // Third Header and Grid
                      HomeSelectHeader(
                        categoryTitle: 'New Sellers',
                        onSeeAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CatScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Fetchwatchs(
                          itemCount: 2,
                          futureFunction:
                              WatchController().getSortedWatchsByCreationDate())
                    ],
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
