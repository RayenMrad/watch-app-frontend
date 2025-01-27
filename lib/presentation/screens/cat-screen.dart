import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/presentation/controller/category_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/screens/watch-screen.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/headers/header.dart';
import 'package:clean_arch/presentation/widgets/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerContents(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                title: 'Categories',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              Expanded(
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Products you May Liked",
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
                                        itemCount:
                                            controller.allCategories.length,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller
                                                    .allCategories[index].name,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    } else {
                                      return const Center(
                                          child:
                                              Text('Error loading categories'));
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: GetBuilder(
                              init: WatchController(),
                              builder: (watchcontoller) {
                                return FutureBuilder(
                                  future: watchcontoller.getAllWatchs(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                        child: Text('Error loading watches'),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                        child: Text('No watches available'),
                                      );
                                    }
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 3 / 3,
                                      ),
                                      itemCount:
                                          watchcontoller.watchsList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print(watchcontoller
                                                .watchsList[index].id);
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => WatchPage(
                                                    watch: watchcontoller
                                                        .watchsList[index]),
                                              ),
                                            );
                                          },
                                          child: WatchItem(
                                            watch: watchcontoller
                                                .watchsList[index],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
