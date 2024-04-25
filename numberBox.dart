// ignore_for_file: file_names



import 'package:flutter/cupertino.dart';

import '../constants/colors.dart';

class NumberBox extends StatelessWidget {
  final int number;
  final bool selected;

  const NumberBox({super.key, required this.number, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? whiteColor : buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$number',
        style: const TextStyle(
          color: blackColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
