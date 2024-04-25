// ignore_for_file: file_names


import 'package:flutter/cupertino.dart';

import '../constants/colors.dart';

class OptionBox extends StatelessWidget {
  final String letter;
  final bool showResult;
  final bool enabled; // Add enabled property
  final VoidCallback? onPressed; // Make onPressed nullable

  const OptionBox({
    super.key,
    required this.letter,
    required this.showResult,
    required this.enabled, // Add enabled property
    this.onPressed, // Make onPressed nullable
  });

  @override
  Widget build(BuildContext context) {
    Color color = showResult ? bgColor : buttonColor;

    return GestureDetector(
      onTap: enabled
          ? onPressed
          : null, // Check if enabled before invoking onPressed
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              enabled ? color : bgColor, // Change color based on enabled state
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          letter,
          style: const TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
