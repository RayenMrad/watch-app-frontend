import 'package:clean_arch/presentation/widgets/cart-header.dart';
import 'package:clean_arch/presentation/widgets/product-body.dart';
import 'package:flutter/material.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(children: [
          CartHeader(title: 'Watch Page'),
          Expanded(
            child: Builder(builder: (context) {
              return Container(
                color: Colors.white,
                child: WatchBody(),
              );
            }),
          )
        ])
      ],
    );
  }
}
