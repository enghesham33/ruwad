import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomLoginPasswordInput extends StatefulWidget {
  const CustomLoginPasswordInput({super.key, required this.passwordController, required this.onSaved});

  final TextEditingController passwordController;
  final Function(String) onSaved;

  @override
  State<CustomLoginPasswordInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomLoginPasswordInput> {

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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _isHidden,
      keyboardType: TextInputType.visiblePassword,
      validator: (String? password) => validatePasswordFormat(password),
      cursorColor: Theme.of(context).focusColor,
      decoration: AppStyles.inputDecoration.copyWith(
        label: Text(AppLocalizations.of(context)!.password,
        style: Theme.of(context).textTheme.headlineMedium,),
        focusColor: Palette.accentColor,
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
    );
  }
}
