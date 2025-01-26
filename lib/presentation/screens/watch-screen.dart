import 'package:clean_arch/presentation/widgets/cart/cart-header.dart';
import 'package:clean_arch/presentation/widgets/product/product-body.dart';
import 'package:flutter/material.dart';

class WatchPage extends StatefulWidget {
  final dynamic watch;
  const WatchPage({super.key, required this.watch});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            CartHeader(title: 'Watch Page'),
            Expanded(
              child: Builder(builder: (context) {
                return Container(
                  color: Colors.white,
                  child: WatchBody(watch: widget.watch),
                );
              }),
            )
          ])
        ],
      ),
    );
  }
}
