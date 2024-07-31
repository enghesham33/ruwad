import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';

import '../../../../shared/alerts/custom_snack_bar.dart';
import '../../view_model/profile_view_model.dart';

class CustomUpdateProfileForm extends StatefulWidget {
  const CustomUpdateProfileForm({super.key,});

  @override
  State<CustomUpdateProfileForm> createState() => _CustomUpdateProfileFormState();
}

class _CustomUpdateProfileFormState extends State<CustomUpdateProfileForm> {

  final formKey = GlobalKey<FormState>();
  String dialCode = "+966";

  String? validateMobileFormat(String? value) {
    if (value != null && value != '') {
      // starts with number between 1 and 9, contains only digits, and length between 5 and 15.
      // RegExp regex = RegExp(r'^[0-9][0-9]{4,14}$');//RegExp(r'(05|5)([503649187])([0-9]{7})');
      final RegExp regex = RegExp(r'^(?!0)\d{9,14}$');
      if (!regex.hasMatch(value)) {
        return AppLocalizations.of(context)!.validation_format_phone;
      }
    } else {
      return AppLocalizations.of(context)!.validation_required;
    }
    return null;
  }

  static validateIdNumber(String? idNumber, BuildContext context) {
    if (idNumber != null && idNumber.trim().isNotEmpty) {
      if (idNumber.length < 10) {
        return AppLocalizations.of(context)!.validation_format_name;
      }
    } else {
      return AppLocalizations.of(context)!.validation_required;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ProfileViewModel>(
        builder: (context, watch, child) => FloatingActionButton(
          onPressed: () {
            CustomDialog(context).showForm(
                title: AppLocalizations.of(context)!.update,
                content: Form(
                  key: formKey,
                  child: SizedBox(
                    width: 300.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                      TextFormField(
                      // controller: widget.phoneController,
                      initialValue: watch.phoneInput!.replaceAll(dialCode, ""),
                      maxLines: 1,
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (String? number) => validateMobileFormat(number),
                      cursorColor: Theme.of(context).focusColor,
                      decoration: AppStyles.inputDecoration.copyWith(
                          prefixIcon: Consumer<SettingsViewModel>(
                            builder:(context, watch, child)=> CountryCodePicker(
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
                        watch.setPhoneInput(phone: dialCode + phoneNumber!);
                      },
                    ),
                        TextFormField(
                          cursorColor: Theme.of(context).focusColor,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.profile_id_number,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                          ),
                          validator: (String? value) => validateIdNumber(value, context),
                          keyboardType: TextInputType.name,
                          // controller: idNumberController,
                          initialValue: watch.idNumberInput,
                          maxLength: 10,
                          maxLines: 1,
                          onSaved: (value){
                            watch.setIDNumberInput(idNumber: value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                submitForm: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    await watch.updateProfile(context: context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar.warning(
                           error: AppLocalizations.of(context)!.message_registration_required_fields,
                          context: context,
                        ),
                    );
                  }
                },
                );
          },
          child: const Icon(Icons.edit),
        ),
      );
  }
}
