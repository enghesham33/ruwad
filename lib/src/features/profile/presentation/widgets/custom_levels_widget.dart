import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/level.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_small_container.dart';
import 'package:rawdat_hufaz/src/shared/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_tag.dart';

import '../screens/level_details_screen.dart';

class CustomLevelsList extends StatelessWidget {
  const CustomLevelsList({super.key, required this.levels, required this.size});
  final List<LevelModel> levels;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 8, top: 16),
            child: Text(
              AppLocalizations.of(context)!.levels,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: size.height * 0.20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final LevelModel level = levels[index];
                return CustomSmallContainer(
                    size: size,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LevelDetailsScreen(levelID: levels[index].id.toString() )),
                      );
                    },
                    color: level.status == LevelStatus.active
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.4),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(level.description!, style: Theme.of(context).textTheme.bodyLarge, maxLines: 3, overflow: TextOverflow.ellipsis),
                            // Text(level.name!, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                            // Text(level.quota!, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                            SizedBox(height: 24,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomTag(
                                  text: level.status == LevelStatus.active ? AppLocalizations.of(context)!.level_status_ongoing : AppLocalizations.of(context)!.level_status_ended,
                                  foregroundColor:  level.status == LevelStatus.active ? Palette.lightAccentColor : null ,
                                  borderColor: level.status == LevelStatus.active ? Palette.lightAccentColor : null ,
                                ),
                              ],
                            ),
                            // Text(level.status!.name, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    )
                );
              },
            ),
          ),
        ],
      );
  }
}