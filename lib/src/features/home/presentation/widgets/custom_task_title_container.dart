import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import '../../../../shared/themes/palette.dart';
import '../../../settings/view_model/settings_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomTasksTitleContainer extends StatelessWidget {
  const CustomTasksTitleContainer({ Key? key, required this.quorum, required this.size}) : super(key: key);

  final String quorum;
  final Size size;

  @override
  Widget build(BuildContext context) {

    Widget quorumText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${AppLocalizations.of(context)!.surah} $quorum",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Palette.black),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return context.read<SettingsViewModel>().isEnglish()
            ? Container(
          width: size.width,
          height: 68,
          padding: const EdgeInsets.symmetric( horizontal: 24),
          decoration: BoxDecoration(
            color: Palette.lightAccentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppStyles.containerSmallBorderRadius),
              topRight: Radius.circular(AppStyles.containerBigBorderRadius),
            ),
          ),
          child: quorumText
        )
            :  Container(
          width: size.width,
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Palette.lightAccentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppStyles.containerBigBorderRadius),
              topRight: Radius.circular(AppStyles.containerSmallBorderRadius),
            ),
          ),
          child: quorumText
    );
  }
}