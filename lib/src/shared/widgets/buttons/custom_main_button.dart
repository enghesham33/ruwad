import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton(
      {super.key, required this.title, this.child, required this.onPress, this.icon});

  final String title;
  final Widget? child;
  final VoidCallback onPress;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        textColor: const Color.fromRGBO(57, 81, 68, 1),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              gradient: const LinearGradient(colors: [
              //   Color.fromRGBO(170, 190, 131, 1),
              //   Color.fromRGBO(245, 254, 177, 1),
                Palette.lightPrimaryColor,
                Palette.lightOlive,
              ])),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  icon ?? Container()
                ],
              ),
        ),
      ),
    );
  }
}
