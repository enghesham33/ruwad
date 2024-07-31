import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';

class CustomWeekDateRows extends StatelessWidget {
  const CustomWeekDateRows({super.key, required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SettingsViewModel>(
        builder: (context, watch, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.start_date,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                    SizedBox(
                        width: 100,
                        child:
                        Text(
                          watch.getCulturedDate(date: startDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.end,
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.end_date,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                   SizedBox(
                        width: 100,
                        child:
                        Text(
                          watch.getCulturedDate(date: endDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.end,
                        ),
                      ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Column old(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.start_date,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Text(
                    context.read<SettingsViewModel>().getCulturedDay(date: startDate, context: context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 100,
                    child:
                    Text(
                      context.read<SettingsViewModel>().getCulturedDate(date: startDate),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.end_date,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Text(
                    context.read<SettingsViewModel>().getCulturedDay(date: endDate, context: context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 100,
                    child:
                    Text(
                      context.read<SettingsViewModel>().getCulturedDate(date: endDate),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
  }
}
