import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rawdat_hufaz/src/features/profile/data/models/certificate.dart';

import 'custom_section_container.dart';

class CertificateSectionsList extends StatelessWidget {
  const CertificateSectionsList({
    super.key,
    required this.sections,
  });

  final List<SectionModel> sections;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 16, bottom: 8, top: 16),
          child: Text(
            AppLocalizations.of(context)!.level_certificate,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        ...sections.map(
              (section) => CustomSectionContainer(section: section, size: size),
            ).toList(),
      ],
    );
  }
}
