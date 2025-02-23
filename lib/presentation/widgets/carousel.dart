import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final urlImages = [
    'http://192.168.1.13:8000/uploads/images/carousel/rolex.jpg',
    'http://192.168.1.13:8000/uploads/images/carousel/cartier.jpg',
    'http://192.168.1.13:8000/uploads/images/carousel/patek.jpg',
    'http://192.168.1.13:8000/uploads/images/carousel/tag.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        options: CarouselOptions(height: 200),
        itemCount: urlImages.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = urlImages[index];
          return buildImage(urlImage, index);
        },
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
