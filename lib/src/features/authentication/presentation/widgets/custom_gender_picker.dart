import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomGenderPicker extends FormField<Gender> {
  // final Function(Gender) onSelect;
  // final Gender? value;
  final BuildContext context;
  final Size size;

  validateGender(value, BuildContext context) {
    if (value == null) {
      return AppLocalizations.of(context)!.validation_required;
    }
    return null;
  }

  CustomGenderPicker({
    super.key,
    required FormFieldSetter<Gender> onSaved,
    required this.context,
    required this.size,
    // required FormFieldValidator<int> validator,
    Gender initialValue = Gender.female,
  }) : super(
      onSaved: onSaved,
      validator: (value) {
        if (value == null) {
          return "AppLocalizations.of(context)!.validation_required";
        }
        return null;
      },
      initialValue: initialValue,
      builder: (FormFieldState<Gender> state) {
        return Column(
          children: [
            Wrap(spacing: 16, children: [
              ChoiceChip(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                label: SizedBox(
                  width: size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.male,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const Icon(Icons.male),
                    ],
                  ),
                ),
                selectedColor: Palette.lightPrimaryColor,
                selected: state.value == Gender.male,
                onSelected: (selected) {
                  state.didChange(Gender.male);
                  onSaved(Gender.male);
                },
              ),
              ChoiceChip(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                label: SizedBox(
                  width: size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.female,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const Icon(Icons.male),
                    ],
                  ),
                ),
                selectedColor: Palette.lightPrimaryColor,
                selected: state.value == Gender.female,
                onSelected: (selected) {
                  state.didChange(Gender.female);
                  onSaved(Gender.female);
                },
              ),
            ]),
            state.isValid
                ? const SizedBox()
                : Text(
              state.errorText ?? AppLocalizations.of(context)!.validation_required,
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: Palette.red),
            ),
          ],
        );
      }
  );

  @override
  CustomGenderPickerState createState() => CustomGenderPickerState();
}

class CustomGenderPickerState extends FormFieldState<Gender> {
  @override
  CustomGenderPicker get widget => super.widget as CustomGenderPicker;
}
