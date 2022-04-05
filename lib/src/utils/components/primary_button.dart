import 'package:flutter/material.dart';
import 'package:pavlok_challenge/src/utils/constants/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.radius = 10,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String title;
  final double radius;
  final double width;
  final double height;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        margin: EdgeInsets.zero,
        elevation: 8.0,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: AppGradients.buttonGradient,
          ),
          child: Center(
            child: Text(title, style: AppTextStyles.buttonTitle),
          ),
        ),
      ),
    );
  }
}
