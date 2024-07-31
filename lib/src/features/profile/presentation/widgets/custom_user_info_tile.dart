import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/authentication/data/models/user.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';

import 'custom_info_field.dart';

class CustomUserInfoTile extends StatelessWidget {
  const CustomUserInfoTile({super.key, required this.user, required this.size});
  final UserModel? user;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomBigContainer(
        size: size,
        color: Theme.of(context).cardColor,
        child: user == null ?
        SizedBox(
          height: size.height * 0.8,
          child: const Center(child: CircularProgressIndicator()),
        )
        : ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.profile_personal_info,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      color: Palette.lightGray.withOpacity(0.4),
                    ),
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: [
                      CustomInfoField(
                        label:
                        AppLocalizations.of(context)!.first_name,
                        value: user!.firstName,
                      ),
                      CustomInfoField(
                        label:
                        AppLocalizations.of(context)!.last_name,
                        value: user!.lastName,
                      ),
                    ]),
                    TableRow(children: [
                      CustomInfoField(
                        label:
                        AppLocalizations.of(context)!.phone,
                        value: user!.phone.toString(),
                      ),
                      CustomInfoField(
                        label:
                        AppLocalizations.of(context)!.profile_id_number,
                        value: user!.idNumber.toString(),
                      ),
                    ]),
                    TableRow(children: [
                      CustomInfoField(
                        label: AppLocalizations.of(context)!.profile_age,
                        value: user!.age.toString(),
                      ),
                      CustomInfoField(
                        label: AppLocalizations.of(context)!.gender,
                        value: user!.gender!.name == Constants.female ? AppLocalizations.of(context)!.female : AppLocalizations.of(context)!.male,
                      ),
                    ]),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
