import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import '../../themes/app_styles.dart';
import '../../themes/palette.dart';

class CustomBigContainer extends StatelessWidget {
  const CustomBigContainer({Key? key, this.title = "", required this.child, this.color = Palette.primaryColor, this.onTap, required this.size})
      : super(key: key);

  final Widget child;
  final String title;
  final Color color;
  final Function? onTap;
  final Size size;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        onTap?.call();
      },
      child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius:context.read<SettingsViewModel>().isEnglish()? AppStyles.englishBorder : AppStyles.arabicBorder,
            boxShadow: [
              AppStyles.containerBoxShadow,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only( left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title.isEmpty ? const SizedBox() :
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                child
              ],
            ),
          ),
        ),
    );
  }
}