import 'package:clean_arch/presentation/screens/categories-screen.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/grid-container.dart';
import 'package:clean_arch/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

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
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: Drawer(
        child: DrawerContents(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                title: 'Home Page',
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
                                    "Discover Timeless Elegance",
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
                            // Using the CategoryGridSection widget with dynamic parameters
                            GridContainerSection(
                              categoryTitle:
                                  "Categories", // Dynamic category title
                              onSeeAllPressed: () {
                                // Navigation or action when "See All" is pressed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoriesScreen(),
                                  ),
                                );
                                print("Navigate to luxury watches");
                              },
                              itemCount: 2, // Number of grid items
                            ),
                            GridContainerSection(
                              categoryTitle:
                                  "Top deals", // Dynamic category title
                              onSeeAllPressed: () {
                                // Navigation or action when "See All" is pressed

                                print("Navigate to luxury watches");
                              },
                              itemCount: 4, // Number of grid items
                            ),
                            GridContainerSection(
                              categoryTitle:
                                  "New Arrivals Section", // Dynamic category title
                              onSeeAllPressed: () {
                                // Navigation or action when "See All" is pressed
                                print("Navigate to luxury watches");
                              },
                              itemCount: 2, // Number of grid items
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
