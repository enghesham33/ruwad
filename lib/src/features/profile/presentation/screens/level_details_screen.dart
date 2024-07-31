import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/profile/view_model/levels_view_model.dart';

import '../widgets/certtificate_sections_list.dart';
import '../widgets/custom_level_info_container.dart';

class LevelDetailsScreen extends StatefulWidget {
  const LevelDetailsScreen({
    super.key,
    required this.levelID,
  });

  final String levelID;

  @override
  State<LevelDetailsScreen> createState() => _LevelDetailsScreenState();
}

class _LevelDetailsScreenState extends State<LevelDetailsScreen> {

  late final LevelsViewModel levelsViewModel;

  @override
  initState() {
    levelsViewModel = Provider.of<LevelsViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
          () => levelsViewModel.loadLevelDetails(context: context, levelID: widget.levelID),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<LevelsViewModel>(
      builder: (context, watch, child) =>Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.level_details,
              ),
              elevation: 0,
            ),
            body:  watch.isLoading || watch.level == null
                ? SizedBox(
              height: size.height * 0.8,
              child: const Center(child: CircularProgressIndicator()),
            )
                : SingleChildScrollView(
                  child: Column(
              children: [
                  CustomLevelInfoContainer(level: watch.level!,),
                  CertificateSectionsList(sections: watch.certificate!.sections!,)
              ],
            ),
                ),
      ),
    );
  }
}
