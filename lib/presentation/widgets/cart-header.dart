import 'package:flutter/material.dart';

class CartHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuPressed; // Callback for menu button (optional)

  const CartHeader({Key? key, required this.title, this.onMenuPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.2,
      decoration: const BoxDecoration(
        color: Colors.white, // Changed to blue for better text visibility
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: onMenuPressed ?? () {}, // Uses the provided callback
            ),
          ],
        ),
      ),
    );
  }
}
