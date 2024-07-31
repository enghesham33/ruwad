import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/exams/presentation/screens/exam_details_screen.dart';
import 'package:rawdat_hufaz/src/features/exams/presentation/widgets/exam_summary.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_small_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_no_data_widget.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_tag.dart';
import '../../view_model/exams_view_model.dart';

class ExamsListScreen extends StatefulWidget {
  const ExamsListScreen({super.key});

  static String routeName = "ExamsList";

  @override
  State<ExamsListScreen> createState() => _ExamsListScreenState();
}

class _ExamsListScreenState extends State<ExamsListScreen> {
  late final ExamsViewModel examsViewModel;

  @override
  void initState() {
    examsViewModel = Provider.of<ExamsViewModel>(context, listen: false);
    Future.delayed( Duration.zero, () => examsViewModel.loadExams(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const SizedBox spacer = SizedBox(
      height: 24,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.exams_and_scores),
      ),
      body: Consumer<ExamsViewModel>(
        builder: (context, watch, child) => watch.isLoadingExams
            ? Center(
                child: SizedBox(
                  height: 100.h,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              )
            : watch.exams.isEmpty //|| watch.exams == null
                ? SizedBox(
                    height: size.height * 0.8,
                    child: CustomNoDataWidget(
                      displayImage: true,
                      text: AppLocalizations.of(context)!.message_no_data_title,
                      subText: AppLocalizations.of(context)!.message_no_exams,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spacer,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, bottom: 16, right: 16),
                          child: Text(
                              AppLocalizations.of(context)!.result_summary,
                              style: Theme.of(context).textTheme.headlineLarge),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ExamSummary(
                            size: size,
                            summaryData: watch.examsSummary,
                          ),
                        ),
                        spacer,
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16, ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.exams,
                                  style: Theme.of(context).textTheme.headlineLarge),
                              FilterChip(
                                  selectedColor: Palette.lightPrimaryColor,
                                  backgroundColor: Palette.gray.withOpacity(0.5),
                                  checkmarkColor: Palette.white,
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                                    child: Text(
                                        AppLocalizations.of(context)!.all,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white)),
                                  ),
                                  selected: watch.showAll,
                                  onSelected: (selected) {
                                    watch.selectAll();
                                  }),
                            ],
                          ),
                        ),
                        // ============================= status filter ============================== //
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16,),
                                  child: Text(
                                      AppLocalizations.of(context)!.status,
                                      style: Theme.of(context).textTheme.labelMedium),
                                ),
                                ...watch.examsStatusList
                                  .map((status) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: FilterChip(
                                            backgroundColor: Palette.gray.withOpacity(0.5),
                                            checkmarkColor: Palette.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            selectedColor: status.color,
                                            label: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                                              child: Text(status.titleAr, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white)),
                                            ),
                                            selected: watch.selectedExamStatuses.contains(status),
                                            onSelected: (selected) {
                                                watch.selectStatus(status);
                                            }),
                                      ))
                                  ,]
                            ),
                          ),
                        ),
                        // ==============================  types filter ==============================  //
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16,),// bottom: 8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.type,
                                      style: Theme.of(context).textTheme.labelMedium),
                                ),
                                ...watch.examsTypeList.map((type) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: FilterChip(
                                            backgroundColor: Palette.gray.withOpacity(0.5),
                                            checkmarkColor: Palette.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            selectedColor: type.color,
                                            // color: Palette.gray,
                                            label: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                                              child: Text(type.title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.white)),
                                            ),
                                            selected: watch.selectedExamTypes.contains(type),
                                            onSelected: (selected) {
                                                watch.selectType(type);
                                            }),
                                      ))
                                  ,]
                            ),
                          ),
                        ),
                        // ============================== filtered exams ============================== //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GridView.builder(
                              // scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              ),
                              itemCount: watch.filteredExams.length,
                              itemBuilder: (context, index) {
                                var item = watch.filteredExams[index];
                                return CustomSmallContainer(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50),
                                          ),
                                        ),
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        useSafeArea: true,
                                        builder: (BuildContext context) {
                                          return ExamDetailsScreen(
                                            examID: item.id!,
                                          );
                                        });
                                  },
                                  color: Theme.of(context).cardColor,
                                  size: size,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                          child: Center(
                                            child: Text(
                                              item.name!,
                                              style: Theme.of(context).textTheme.bodyLarge,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                                                  child: CustomTag(
                                                    text: item.type == null
                                                        ? ''
                                                        : item.type!.title,
                                                    backgroundColor: item.type?.color,
                                                    //item.status?.color.withOpacity(0.5),
                                                    foregroundColor:  Palette.white,
                                                    borderColor: item.type?.color,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                                                  child: CustomTag(
                                                    text: item.status == null
                                                        ? ''
                                                        : item.status!.titleAr,
                                                    backgroundColor: item.status?.color,
                                                    //item.status?.color.withOpacity(0.5),
                                                    foregroundColor:  Palette.white,
                                                    borderColor: item.status?.color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
