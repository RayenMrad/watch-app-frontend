import 'package:flutter/material.dart';

class CartWatchList extends StatefulWidget {
  const CartWatchList({super.key});

  @override
  State<CartWatchList> createState() => _CartWatchListState();
}

class _CartWatchListState extends State<CartWatchList> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Watch Image
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                    'assets/images/watch5.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Watch Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Citizen Men\'s Sport Casual',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      '350 dt',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFAF6767),
                      ),
                    ),
                    SizedBox(
                      width: 85,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      icon: const Icon(Icons.remove, size: 18),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(Icons.add, size: 18),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                )
                // Quantity Selector
              ],
            ),
          ),
        ],
      ),
    );
  }
}
