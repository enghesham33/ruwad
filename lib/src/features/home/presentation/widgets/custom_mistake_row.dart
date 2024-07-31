import 'package:flutter/material.dart';

class CustomMistakeRow extends StatelessWidget {
  const CustomMistakeRow({super.key, required this.count, required this.type, required this.deduction});

  final String type;
  final int count;
  final int deduction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$count  $type",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("${deduction.toStringAsFixed(0)} -",
                style: Theme.of(context).textTheme.bodyLarge//!.copyWith(color: Palette.red,),
            ),
          ),
        )
      ],
    );
  }
}