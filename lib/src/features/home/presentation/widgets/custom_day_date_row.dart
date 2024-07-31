import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';

class CustomDayDateRow extends StatelessWidget {
  const CustomDayDateRow({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SettingsViewModel>(
        builder: (context, watch, child) =>  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                watch.getCulturedDay(date: date, context: context),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                watch.getCulturedDate(date: date),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
      ),
    );
  }
}