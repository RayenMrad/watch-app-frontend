import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.black,
                    child: Container(
                      height: height * 0.8,
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
                            // Add a constrained height for the GridView
                            Expanded(
                              child: GetBuilder<WatchController>(
                                  init: WatchController(),
                                  builder: (controller) {
                                    return FutureBuilder(
                                        future: controller.getAllWatchs(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 16,
                                                mainAxisSpacing: 16,
                                                childAspectRatio: 3 / 3,
                                              ),
                                              itemCount: 10,
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                color: Colors.amberAccent,
                                              ),
                                            );
                                          }
                                        });
                                  }),
                            ),
                          ],
                        ),
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
