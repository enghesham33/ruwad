import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomBirthYearPicker extends FormField<int> {

  final Function(int) onChanged;
  final int value;
  final BuildContext context;
  static int minBirthYear = DateTime.now().year - 100;
  static int maxBirthYear = DateTime.now().year - 5;

  CustomBirthYearPicker({
    super.key,
    required this.onChanged,
    required this.value,
    required this.context,
    FormFieldValidator<int>? validator,
  }) : super(
            validator: (value) {
              if (value == null) {
                return AppLocalizations.of(context)!.validation_required;
              }
              if (value <= minBirthYear && value >= maxBirthYear) {
                return AppLocalizations.of(context)!.validation_birth_year;
              }
              return null;
            },
            initialValue: value,
            builder: (field) {
              return Column(
                children: [
                  NumberPicker(
                    value: value,
                    minValue: minBirthYear,
                    maxValue: maxBirthYear,
                    step: 1,
                    // itemHeight: 40,
                    axis: Axis.horizontal,
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    selectedTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: Palette.accentColor),
                    onChanged: (value) {
                      onChanged(value);
                    },
                  ),
                  field.isValid
                      ? const SizedBox()
                      : Text(
                          field.errorText ?? AppLocalizations.of(context)!.validation_birth_year,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.red),
                  ),
                ],
              );
            });

  @override
  CustomNumberPickerState createState() => CustomNumberPickerState();
}

class CustomNumberPickerState extends FormFieldState<int> {
  @override
  CustomBirthYearPicker get widget => super.widget as CustomBirthYearPicker;
}
