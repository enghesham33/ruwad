import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/models/card_transaction.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.size,
    required this.transaction,
    required this.title,
    required this.color,
  });

  final Size size;
  final TransactionModel transaction;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        leading: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
        ),
        title: Consumer<SettingsViewModel>(
                  builder: (context, watch, child) => Center(
                    child: Text(
                        watch.getCulturedDate(date: transaction.date?? DateTime.now()),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
        trailing:
            SizedBox(
              width: 40.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star_half_sharp,
                    size: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    color: Colors.yellow.shade700,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${transaction.points!}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
