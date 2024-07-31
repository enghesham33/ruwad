import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomRegistrationPasswordInput extends StatefulWidget {
  const CustomRegistrationPasswordInput({super.key, required this.passwordController, required this.confirmPasswordController, required this.onSaved});

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function(String) onSaved;

  @override
  State<CustomRegistrationPasswordInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomRegistrationPasswordInput> {

  bool _isHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String? validatePasswordFormat(String? value) {
    if (value == null || value.isEmpty ) {
      return AppLocalizations.of(context)!.validation_required;
    }
    if ( widget.confirmPasswordController.text.isEmpty ) {
      return "confirm password";//AppLocalizations.of(context)!.validation_required;
    }
    if (widget.passwordController.text != widget.confirmPasswordController.text) {
      return 'Password and confirm Password should match';//AppLocalizations.of(context)!.;
    }
    // RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!\w]).{8,}$');
    // if (!regex.hasMatch(value)) {
    //   return 'Password should contain at least one special character, a number, a uppercase and a lowercase letter';//AppLocalizations.of(context)!.;
    // }
    return null;
  }

  String? confirmPassword(String? value) {
    if (value == null || value.isEmpty ) {
      return AppLocalizations.of(context)!.validation_required;
    }
    if (widget.passwordController.text == widget.confirmPasswordController.text) {
      return 'Password and confirm Password should match';//AppLocalizations.of(context)!.;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.passwordController,
          obscureText: _isHidden,
          keyboardType: TextInputType.visiblePassword,
          validator: (String? password) => validatePasswordFormat(password),
          cursorColor: Theme.of(context).focusColor,
          decoration: AppStyles.inputDecoration.copyWith(
            label: Text(AppLocalizations.of(context)!.password, ),
            suffix: GestureDetector(
              child: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
              onTap: () {
                _togglePasswordVisibility();
              },
            ),
          ),
          onSaved: (password){
            widget.onSaved(password!);
          },
        ),
        const SizedBox(height: 16,),
        TextFormField(
          controller: widget.confirmPasswordController,
          obscureText: _isHidden,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Theme.of(context).focusColor,
          decoration: AppStyles.inputDecoration.copyWith(
            label: Text(AppLocalizations.of(context)!.confirm_password, ),
            suffix: GestureDetector(
              child: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
              onTap: () {
                _togglePasswordVisibility();
              },
            ),
          ),
        ),
      ],
    );
  }
}
