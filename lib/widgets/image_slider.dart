import 'package:demo_catalog_app/constants/animations.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ImageIndexIndicator extends StatelessWidget {
  final int currentPage;
  final int length;

  ImageIndexIndicator({required this.currentPage, required this.length});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Dot(currentPage: currentPage, index: index),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);

  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
