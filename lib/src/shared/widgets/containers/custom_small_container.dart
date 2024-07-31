import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../features/settings/view_model/settings_view_model.dart';
import '../../themes/app_styles.dart';
import '../../themes/palette.dart';

class CustomSmallContainer extends StatelessWidget {
  const CustomSmallContainer({
    Key? key,
    required this.child,
    required this.onTap,
    this.color = Palette.lightOlive,
    required this.size,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final Function onTap;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child:
          Container(
          width: size.width * 0.6,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: context.read<SettingsViewModel>().isEnglish()? AppStyles.englishBorder : AppStyles.arabicBorder,
            boxShadow: [
              AppStyles.containerBoxShadow
            ],
          ),
          child: child,
          // child: SingleChildScrollView(child: child),
        ),
    );
  }
}