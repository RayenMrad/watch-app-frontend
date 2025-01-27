import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/variant_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWatchList extends StatefulWidget {
  final Sales sales;
  const CartWatchList({Key? key, required this.sales}) : super(key: key);

  @override
  State<CartWatchList> createState() => _CartWatchListState();
}

class _CartWatchListState extends State<CartWatchList> {
  final WatchController watchController = Get.find();
  final VariantController variantController = Get.find();
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.sales.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final variantId = widget.sales.variantId;

    // final variantDetails = variantController.getVariantById(variant);
    // final watchId = cartController.getWatchIdFromVariant(variant);
    // final watchDetails = watchController.getWatchById(watchId);

    return FutureBuilder(
        future: _getVariantAndWatchDetails(variantId),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          }
          final data = snapshot.data!;
          Variant variant = data['variant'];
          final watch = watchController.allWatchs
              .firstWhere((element) => element.id == variant.watchId);
          print(variant.watchId);

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
                    color: Colors.grey[200],
                    image: variant.imageColor != null
                        ? DecorationImage(
                            image: NetworkImage(variant.imageColor!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: variant.imageColor == null
                      ? const Icon(Icons.image, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
                // Watch Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        watch.name ?? 'Product Name',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '${widget.sales.totalprice ?? '0'} dt',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFAF6767),
                            ),
                          ),
                          const Spacer(),
                          // Quantity Selector
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<Map<String, dynamic>> _getVariantAndWatchDetails(
      String variantId) async {
    try {
      // Fetch Variant
      final variant = await variantController.getVariantById(variantId);
      print(variant.watchId);

      // Fetch Watch using watchId from Variant
      final watch = await watchController.getWatchById(variant.watchId);
      // if (watch == null)
      //   throw Exception('Watch not found for ID: ${variant.watchId}');

      // Debug Watch Data

      return {'variant': variant, 'watch': watch};
    } catch (e) {
      debugPrint('Error fetching details: $e');
      throw e;
    }
  }
}
