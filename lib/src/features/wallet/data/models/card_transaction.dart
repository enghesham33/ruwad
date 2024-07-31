import 'package:intl/intl.dart';

class TransactionModel {
  int? id;
  DateTime? date;
  int? points;

  TransactionModel({
    this.id,
    this.date,
    this.points
  });

  TransactionModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    id = json["ID"] ?? "";
    date = DateFormat("dd-MM-yyyy").parseStrict(json["date"]);
    points = json["points"] ?? 0;
  }
}