import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get itemCount => null;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: Drawer(
        child: DrawerContents(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                title: 'Favorites',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                },
              ),
              Expanded(
                child: SingleChildScrollView(
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
                          children: [
                            // Centered Title and Subheading
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "Your Favorites Watchs",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Space between title and subheading
                                  const Text(
                                    "Find the perfect watch to match your style",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF9F9F9F), // Gray color
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 20), // Space before grid
                                ],
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap:
                                  true, // Important to avoid infinite height issues
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable scrolling for GridView inside SingleChildScrollView
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 10, // Space between columns
                                mainAxisSpacing: 10, // Space between rows
                                childAspectRatio:
                                    1.0, // Aspect ratio for grid items
                              ),
                              itemCount:
                                  itemCount, // Number of items to show (dynamic)
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Item $index', // Content of grid item
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
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
