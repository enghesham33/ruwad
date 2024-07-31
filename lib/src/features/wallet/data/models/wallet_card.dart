import 'package:flutter/cupertino.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/call_screen.dart';
import 'package:rawdat_hufaz/src/features/exams/presentation/screens/exams_list_screen.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'card_transaction.dart';

class WalletCardType{
  static WalletCardType exam = WalletCardType(
      value: "exam",
      routeName: ExamsListScreen.routeName,
      color: Palette.darkOlive,
  );
  static WalletCardType completeTasks = WalletCardType(
      value: "complete tasks",
    routeName: HomeScreen.routeName,
      color: Palette.blue,
  );
  static WalletCardType recites = WalletCardType(
      value: "recites",
    routeName: CallsScreen.routeName,
      color: Palette.green,
  );

  final String value;
  final String routeName;
  final Color color;

  const WalletCardType({
    required this.value,
    required this.routeName,
    required this.color,
  });

  static WalletCardType? map(String type) {
    switch (type) {
      case 'exam':
        return WalletCardType.exam;
      case 'complete tasks':
        return WalletCardType.completeTasks;
      case 'recites':
        return WalletCardType.recites;
      default:
        return null;
    }
  }

  String getTitle({required BuildContext ctx}){
    switch (value) {
      case 'exam':
        return AppLocalizations.of(ctx)!.wallet_card_exam_title;
      case 'complete tasks':
        return AppLocalizations.of(ctx)!.wallet_card_completeTasks_title;
      case 'recites':
        return AppLocalizations.of(ctx)!.wallet_card_recites_title;
      default:
        return "";
    }
  }

  String getDescription({required BuildContext ctx}){
    switch (value) {
      case 'exam':
        return AppLocalizations.of(ctx)!.wallet_card_exam_description;
      case 'complete tasks':
        return AppLocalizations.of(ctx)!.wallet_card_completeTasks_description;
      case 'recites':
        return AppLocalizations.of(ctx)!.wallet_card_recites_description;
      default:
        return "";
    }
  }

  String getButtonText({required BuildContext ctx}){
    switch (value) {
      case 'exam':
        return AppLocalizations.of(ctx)!.wallet_card_exam_button;
      case 'complete tasks':
        return AppLocalizations.of(ctx)!.wallet_card_completeTasks_button;
      case 'recites':
        return AppLocalizations.of(ctx)!.wallet_card_recites_button;
      default:
        return "";
    }
  }
}

class WalletCardModel {
  String? id;
  WalletCardType? type;
  String? titleAr;
  String? titleEn;
  String? descriptionAr;
  String? descriptionEn;
  int? value;
  int? points;
  List<TransactionModel> transactions = [];

  WalletCardModel({
    this.id,
    this.type,
    this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.value,
    this.points,
  });

  WalletCardModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    id = json["cardID"] ?? "";
    type = WalletCardType.map(json["cardType"]);
    titleAr = json["title_ar"] ?? "";
    titleEn = json["title_en"] ?? "";
    descriptionAr = json["description_ar"] ?? "";
    descriptionEn = json["description_en"] ?? "";
    value = json["cardValue"] ?? 0;
    points = json["totalPoints"] ?? 0;
    transactions = (json["transactions"] as List).map((exam) {
      return TransactionModel.fromJson(json: exam);
    }).toList();
  }
}




