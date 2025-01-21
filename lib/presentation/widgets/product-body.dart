import 'dart:ffi';

import 'package:flutter/material.dart';

class WatchBody extends StatefulWidget {
  /*final String imageUrl;
  final String watchName;
  final String watchDescription;
  final Double watchPrice;*/

  const WatchBody({
    super.key,
    /*required this.imageUrl,
      required this.watchName,
      required this.watchDescription,
      required this.watchPrice*/
  });

  @override
  State<WatchBody> createState() => _WatchBodyState();
}

class _WatchBodyState extends State<WatchBody> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.8,
      color: Colors.white,
      child: Column(
        children: [
          // Watch image
          Container(
            width: 215,
            height: 269,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Image.asset("assets/images/watch5.png"),
          ),
          const SizedBox(height: 2), // Add spacing between image and text
          // Text description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Text(
              "Watch Description",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15), // Add spacing between text and stars
          // Stars
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center-align the stars
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star_half, color: Colors.amber, size: 24),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          //description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Text(
              "Watch Description",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xFF9F9F9F),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //Price
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Text(
              "350 DT",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAF6767),
              ),
            ),
          ),

          const SizedBox(
            height: 100,
          ),
          Container(
            width: 340,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Add To Cart",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
