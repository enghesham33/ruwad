import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPhoneInput extends StatefulWidget {
  const CustomPhoneInput({super.key, required this.phoneController, required this.onSaved});

  final TextEditingController phoneController;
  final Function(String) onSaved;

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {

  String dialCode = "+966";

  String? validateMobileFormat(String? value) {
    if (value != null && value != '') {
      // starts with number between 1 and 9, contains only digits, and length between 5 and 15.
      // RegExp regex = RegExp(r'^[0-9][0-9]{4,14}$');//RegExp(r'(05|5)([503649187])([0-9]{7})');
      print("Lolo ===>> $value");
      // final RegExp regex = RegExp(r'^(?!0)\d{9,14}$');
      final RegExp regex = RegExp(r'^\d{9,14}$');
      if (!regex.hasMatch(value)) {
        return AppLocalizations.of(context)!.validation_format_phone;
      }
    } else {
      return AppLocalizations.of(context)!.validation_required;
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.phoneController,
      maxLines: 1,
      maxLength: 15,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (String? number) => validateMobileFormat(number),
      cursorColor: Theme.of(context).focusColor,
      decoration: AppStyles.inputDecoration.copyWith(
        prefixIcon: Consumer<SettingsViewModel>(
          builder:(context, watch, child)=>CountryCodePicker(
          initialSelection: "SA",
          dialogBackgroundColor: watch.isDarkMode()?Colors.black:Colors.white,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          backgroundColor: Theme.of(context).canvasColor,
          showOnlyCountryWhenClosed: false,
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          onChanged: (value)
          {
            setState(() {
              dialCode = value.dialCode.toString();
            });
          },
        ),
      )),
      onSaved: (phoneNumber){
        widget.onSaved(dialCode + phoneNumber!);
      },
    );
  }
}
