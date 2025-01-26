import 'package:clean_arch/presentation/screens/cart-screen.dart';
import 'package:clean_arch/presentation/screens/categories-screen.dart';
import 'package:clean_arch/presentation/screens/favorites-screen.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  // List of screens for Bottom Navigation Bar
  final List<Widget> _screens = const [
    HomePage(), // Home screen
    CategoriesScreen(), // Categories screen
    CartPage(), // Cart screen
    FavoritesScreen(), // Favorites screen
    //SettingsScreen(), // Settings screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer for navigation
      drawer: const Drawer(
        child: DrawerContents(),
      ),

      // Display the screen corresponding to the selected index
      body: Center(
        child: _screens[_currentIndex],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFAF6767),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(Icons.category_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite_outline),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }
}
