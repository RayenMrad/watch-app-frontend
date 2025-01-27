import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  final Variant watch;

  const WishlistItem({Key? key, required this.watch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    watch.imageColor,
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: Text(
                  watch.id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  watch.watchId,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 145, 145, 145),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${watch.quantity}\ Dt',
                  style: const TextStyle(
                    color: Color(0xFFAF6767),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
