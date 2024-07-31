import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/shared/enums.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import '../../../../shared/widgets/custom_tag.dart';
import '../../data/models/level.dart';

class CustomLevelInfoContainer extends StatelessWidget {
  const CustomLevelInfoContainer({super.key, required this.level});

  final LevelModel level;

  Widget label(context, String text){
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  final Widget rowSpacer = const SizedBox(
      width: 24
    );

  final Widget horizontalSpacer = const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Divider(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              level.description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
          horizontalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                context,
                AppLocalizations.of(context)!.plan,
              ),
              Expanded(
                child: Text(
                  "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          horizontalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                context,
                AppLocalizations.of(context)!.level,
              ),
              rowSpacer,
              Expanded(
                child: Text(
                  level.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          horizontalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                context,
                AppLocalizations.of(context)!.surah,
              ),
              Expanded(
                child: Text(
                  level.quota ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          horizontalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                context,
                AppLocalizations.of(context)!.status,
              ),
              rowSpacer,
              CustomTag(
                text: level.status == LevelStatus.active ? AppLocalizations.of(context)!.level_status_ongoing : AppLocalizations.of(context)!.level_status_ended,
                foregroundColor:  level.status == LevelStatus.active ? Palette.accentColor : null ,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
