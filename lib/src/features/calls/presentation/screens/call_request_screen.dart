import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/quraan_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/quraan_view_model.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:rawdat_hufaz/src/shared/widgets/buttons/custom_main_button.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallRequestScreen extends StatefulWidget {
  const CallRequestScreen({super.key});

  static String routeName = "CallRequest";

  @override
  State<CallRequestScreen> createState() => _CallRequestScreenState();
}

//todo : integrate with open source API to retrieve السور والايات لكل سورة
class _CallRequestScreenState extends State<CallRequestScreen> {
  QuraanModel? selectedFromSurah;
  QuraanModel? selectedToSurah;
  int? selectedFromAyah;
  int? selectedToAyah;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quranProvider = Provider.of<QuranProvider>(context, listen: false);
      quranProvider.fetchQuraanSourah();
    });

  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: Constants.callAppID /*input your AppID*/,
    appSign: Constants.callAppSign /*input your AppSign*/,
    userID: AuthenticationViewModel.user!.personId!, // evaluator
    userName: AuthenticationViewModel.user!.name!, 
    plugins: [ZegoUIKitSignalingPlugin()],
  );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.recite),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.h),
                  child: Text(
                    AppLocalizations.of(context)!.choose_quorum,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                      child: Text(
                        AppLocalizations.of(context)!.from,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(AppStyles.containerSmallBorderRadius)),
                                border: Border.all()),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.h, vertical: 2.h),
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.h, vertical: 8.h),
                            child: DropdownButton<QuraanModel>(
                              hint: Text(
                                 AppLocalizations.of(context)!.all),
                              isExpanded: true,
                              borderRadius: BorderRadius.all(Radius.circular(AppStyles.containerSmallBorderRadius)),
                              underline: Container(),
                              iconEnabledColor: Theme.of(context).focusColor,
                              focusColor: Theme.of(context).focusColor,
                              menuMaxHeight: 400,
                              value: selectedFromSurah,
                              onChanged: (QuraanModel? newValue) {
                                setState(() {
                                  selectedFromSurah = newValue!;
                                  // Fetch Ayat for selected Surah
                                  // Provider.of<QuranProvider>(context, listen: false).fetchAyatForSurah(newValue);
                                });
                              },
                              items: Provider.of<QuranProvider>(context).surahs.map<DropdownMenuItem<QuraanModel>>(
                                      (QuraanModel surah) {
                                        return DropdownMenuItem<QuraanModel>(
                                          value: surah,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(surah.name),
                                          ),
                                        );
                              }).toList(),
                            ),
                          ),
                        ),
                        selectedFromSurah != null
                            ? Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppStyles.containerSmallBorderRadius,),
                                    ),
                                    border: Border.all()),
                                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.h),
                                margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                                child: DropdownButton<int>(
                                    isExpanded: true,
                                    borderRadius: BorderRadius.all(Radius.circular(AppStyles.containerSmallBorderRadius,),),
                                    underline: Container(),
                                    iconEnabledColor: Theme.of(context).focusColor,
                                    focusColor: Theme.of(context).focusColor,
                                    menuMaxHeight: 400,
                                    value: selectedFromAyah,
                                    items: List<int>.generate(
                                      selectedFromSurah!.numberOfAyahs,
                                      (int index) => index + 1,
                                    ).map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedFromAyah = value;
                                      });
                                    }),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                      child: Text(
                        AppLocalizations.of(context)!.to,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(AppStyles.containerSmallBorderRadius)),
                                border: Border.all()),
                            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.h),
                            margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                            child: DropdownButton<QuraanModel>(
                              hint: Text(AppLocalizations.of(context)!.all),
                              isExpanded: true,
                              borderRadius: BorderRadius.all(Radius.circular(AppStyles.containerSmallBorderRadius)),
                              underline: Container(),
                              iconEnabledColor: Theme.of(context).focusColor,
                              focusColor: Theme.of(context).focusColor,
                              menuMaxHeight: 400,
                              value: selectedToSurah,
                              onChanged: (QuraanModel? newValue) {
                                setState(() {
                                  selectedToSurah = newValue!;
                                  // Fetch Ayat for selected Surah
                                  // Provider.of<QuranProvider>(context, listen: false).fetchAyatForSurah(newValue);
                                });
                              },
                              items: Provider.of<QuranProvider>(context).surahs.map<DropdownMenuItem<QuraanModel>>(
                                      (QuraanModel surah) {
                                        return DropdownMenuItem<QuraanModel>(
                                          value: surah,
                                          child: Text(surah.name),
                                        );
                                      }).toList(),
                            ),
                          ),
                        ),
                        selectedToSurah != null
                            ? Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppStyles.containerSmallBorderRadius,),
                                    ),
                                    border: Border.all()),
                                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.h),
                                margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                                child: DropdownButton<int>(
                                    isExpanded: true,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        AppStyles.containerSmallBorderRadius,
                                      ),
                                    ),
                                    underline: Container(),
                                    iconEnabledColor: Theme.of(context).focusColor,
                                    focusColor: Theme.of(context).focusColor,
                                    menuMaxHeight: 400,
                                    value: selectedToAyah,
                                    items: List<int>.generate(
                                            selectedToSurah!.numberOfAyahs,
                                            (int index) => index + 1).map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedToAyah = value;
                                      });
                                    }),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
               
                 Consumer<CallRequestViewModel>(
                   builder: (context, watch, child)=> CustomMainButton(
                                  title: AppLocalizations.of(context)!.button_do_test,
                                  child: Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: Text(AppLocalizations.of(context)!.confirm),
                                  ),
                                  onPress: () async
                                  {    
                                    //  if(selectedFromSurah!=null && selectedToSurah!=null)
                                    //  {
                                    //  var roomId=AuthenticationViewModel.user!.personId!+DateTime.now().microsecond.toString();
                                    //  var request= CallRequestModel(
                                    //  name:  AuthenticationViewModel.user!.firstName!,
                                    //  userId: AuthenticationViewModel.user!.personId!,
                                    //  gender: AuthenticationViewModel.user!.gender.toString(),
                                    //  fromSourah: selectedFromSurah!.name,
                                    //  fromAyah: selectedFromAyah??1, 
                                    //  toSourah: selectedToSurah!.name,
                                    //  toAyah: selectedToAyah??1,
                                    //  roomId:roomId,
                                    //  soundsMistakes: 0,
                                    //  memorizeMistakes: 0
                                    //  );
                                    //  await watch.create(request: request).then((value) 
                                    //  {
                                    //   watch.setRequest(request);
                                    //   Navigator.pushReplacement(
                                    //    context,
                                    //    MaterialPageRoute(builder: (context) => const CallWaitingScreen()),
                                    //  ); 
                                    //  });
                                    //  }

                                     
                                               
                                  }
                                  ),
                 ),
              ],
            ),
          ),
        ),
    );
  }
}
