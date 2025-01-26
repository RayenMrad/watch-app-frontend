import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  const CustomTextButton({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.onPressed,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
