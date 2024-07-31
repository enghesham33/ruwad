import 'package:flutter/material.dart';

import '../app_assets.dart';

class CustomNoDataWidget extends StatelessWidget {
  const CustomNoDataWidget(
      {super.key, this.text, this.subText, this.action, this.actionName, this.displayImage = false });

  final String? text;
  final String? subText;
  final Function? action;
  final String? actionName;
  final bool displayImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        displayImage ? Flexible(
          child: AspectRatio(
            aspectRatio: 2/1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                AppAssets.NO_DATA,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ) : const SizedBox(),
        text != null
            ? Center(
          child: Text(
            text!,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        )
            : const SizedBox(),
        const SizedBox(height: 16.0),
        subText != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            subText!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        )
            : const SizedBox(),
        action != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () => action!(),
            // textColor: Palette.beige,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: actionName != null
                ? Text(actionName!, style: Theme.of(context).textTheme.displaySmall,)
                : Text("set actionName", style: Theme.of(context).textTheme.displaySmall,),
          ),
        )
            : const SizedBox()
      ],
    );
  }
}