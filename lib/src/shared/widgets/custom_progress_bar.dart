import 'package:flutter/material.dart';

import '../themes/palette.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key? key,
    required this.size,
    required this.value,
    this.showValues = false,
    this.isPercentage = true,
    this.outOf = 100,
  }) : super(key: key);

  final Size size;
  final double value;
  final double outOf;
  final bool showValues;
  final bool isPercentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showValues
            ? Text(
          "${isPercentage ? '%' : ''}${(value * outOf).toInt()}",
          style: Theme.of(context).textTheme.bodyMedium,
        )
            : const SizedBox(),
        Expanded(
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.01,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor: Palette.lightAccentColor.withOpacity(0.8),
                valueColor: const AlwaysStoppedAnimation<Color>(Palette.accentColor),
                value: value,
              ),
            ),
          ),
        ),
        showValues
            ? Text(
          "${(outOf).toInt()}",
          style: Theme.of(context).textTheme.bodyMedium,
        )
            : const SizedBox(),
      ],
    );
  }
}