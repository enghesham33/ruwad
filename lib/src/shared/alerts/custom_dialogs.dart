import 'dart:io';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import '../themes/app_styles.dart';

class CustomDialog {
  CustomDialog(this.context);

  final BuildContext context;

  Future<void> showInstructions({
    required String title,
    required String instructions,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(instructions),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            content: Text(
              instructions,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> showMessage({
    required String message,
    Function? action,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (ctx) => BackdropFilter(
           filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: AlertDialog(
            title: Text(message,
                style: Theme.of(context).textTheme.bodyLarge,),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  action ?? Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> showForm({
    required String title,
    required Future<void> Function() submitForm,
    required Widget content,
  }) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            content: content,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Palette.gray),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await submitForm();
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.submit,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Palette.accentColor),
                ),
              ),
            ],
          );
        },
      );
  }

  Future<void> showLoadingSpinner() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          alignment: Alignment.center,
          width: 200.h,
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                BorderRadius.circular(AppStyles.containerSmallBorderRadius),
          ),
          // height: 150.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 3.h,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                AppLocalizations.of(context)!.loading,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

}
