import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../themes/palette.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CustomSnackBar {


  static SnackBar warning({required BuildContext context, String? label, required String error,}){
    return SnackBar(
      content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.info_outline, color: Palette.orange),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label ?? AppLocalizations.of(context)!.warning, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                Text(error, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white),),
              ],
            ),
          ]
      ),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Palette.darkBackgroundColor,
    );
  }

  static SnackBar error({required BuildContext context, String? label, required GeneralExceptions error,}){
    return SnackBar(
      content: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.dangerous_outlined, color: Palette.red),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label ?? AppLocalizations.of(context)!.error, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.white),),
                Text(error.message, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white),),
              ],
            ),
          ]
      ),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Palette.darkBackgroundColor,
    );
  }

  static SnackBar success({required String text, required BuildContext context}){
    return SnackBar(
      content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Palette.green),
            const Text("  "),
            Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white),),
          ]
      ),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Palette.darkBackgroundColor,
    );
  }

}


