import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomAnswerButton extends StatelessWidget {
  CustomAnswerButton({super.key, required this.answer, required this.onPressed, this.selected = false});

  final String answer;
  final void Function() onPressed;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      // decoration: BoxDecoration(
      //   border: selected ? Border.all(
      //     width: 4,
      //     color: Palette.primaryColor,
      //   ) : null,
      //
      // ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: selected ? const BorderSide(
            color: Palette.lightPrimaryColor,
            width: 3,
          ) : null,
          shape: selected ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ) : null,
          backgroundColor: selected ? Theme.of(context).hoverColor : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(answer,softWrap: true,
            style: selected ? Theme.of(context).textTheme.bodyMedium!.copyWith(
              color:  Palette.primaryColor,
            ) : Theme.of(context).textTheme.bodyMedium!
          ),
        ),
      ),
    );
  }
}